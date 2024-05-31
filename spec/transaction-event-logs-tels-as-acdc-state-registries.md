## Transaction event logs (TELs) as ACDC state registries
<!-- file name: transaction-event-logs-tels-as-acdc-state-registries.md -->
### Overview

A Transaction Event Log (TEL) is a hash-chained data structure of sealed transaction events that can be used to track the transaction states (typically those associated with one or more ACDCs). Events in the TEL are sealed (anchored) in a Key Event Log (KEL) using seals. A seal can be as simple as the event's SAID (cryptographic strength digest). A transaction event seal may also include the transaction event's sequence number to make it easier to look up and verify.  Because key events in a KEL are nonrepudiably signed by its Controller, the appearance of a transaction event seal provides a verifiable non-repudiable commitment to the transaction event by the KEL Controller. This makes TELs, which are thereby bound to KELs, also securely attributable to the KEL's controller.  This provides verifiable but decorrelatable extensibility to KEL semantics. Any number of transaction event types can be constructed for different applications that may be securely attributed without complicating KEL semantics. The seals need no semantics beyond their secure attributability to the AID of the KEL controller. The semantics of the transaction event's state may be hidden by the transaction event SAID, which in turn may be protected from rainbow table attack by a cryptographic strength UUID in the transaction event. Therefore, the transaction state, as given by a sequence of transaction events, can be either public or private, depending on how the transaction events are structured. Similar to ACDCs themselves, Graduated Disclosure mechanisms may be applied to transaction events. 

Importantly, the process of sealing transaction events in a KEL binds the Key State at the sealing (anchoring) key event to the transaction state. This enables an extremely beneficial property of TELs; that is, the verifiability of transaction events in the TEL persists in spite of changes to Key States in the sealing KEL. In other words, the verifiability of transaction events persists in spite of changes in the Key State. To clarify, sealed transaction events remain verifiably bound to the Key State at the point of issuance of the sealing event. An example of a transaction state that benefits from this property is a TEL that tracks the issuance and revocation state of dynamically revocable ACDCs, i.e., a revocation registry.

The transaction events shall be sealed (anchored or bound) in a KEL using transaction event seals, whose JSON representation is as follows.

```json
{
 "s": "3",
 "d": "ELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM"
}
```

The CESR representation of the seal couple is given by the Count Code `-0##` or `-0O#####`


### Validating transaction events

As described above, a KEL can control a TEL by sealing (anchoring) transaction-specific events from the TEL inside key events in the KEL. 
The steps to this process are defined as follows:

1. Assign each TEL a universally unique identifier (such as the SAID of an associated ACDC)
2. Associate each TEL with the KEL's Controller AID that seals the transaction events. This AID is the Issuer of the transaction event.
3. Create the transaction-specific event with an event SAID.
4. Generate a seal that includes the event SAID.
5. Include the seal of that transaction event in a key event in the controlling KEL.
6. Have the sealing key event accepted (appended) into its KEL by the KEL Controller. This means at least signing the sealing key event and may include witnessing and or delegating the event. Such acceptance makes a verifiable, nonrepudiable commitment to the seal (digest) of the serialized transaction event.

Any Validator can cryptographically verify the authoritative state of the transaction by validating the presence of the seal in the associated KEL.  The TEL events themselves do not have to be signed because the signed commitment to the event in the form of the digest in the seal in the KEL is cryptographically equivalent to signing the transaction event itself. Typically, the Validator is given a reference to the sealing event via a key event seal reference that includes the Issuer (KEL Controller) AID, the key event's sequence number, and its SAID. The Issuer of the transaction event can either directly attach the seal reference to the ACDC or can provide an API where transaction events or their seal references and their KEL seal references can be looked up by the SAID of the ACDC associated with the transaction event. Given a key event seal reference for a given transaction event, a Validator can then look up and verify the presence of the seal in the KEL.

### Verifiable Container/Credential Registry

ACDCs may be rightly generically referred to as Verifiable Containers (VCs). Often, ACDCs are used as entitlements or credentials and, therefore, may also be rightly referred to as Verifiable Credentials (VCs). The abbreviation VC works in either case. An ACDC can more simply be denoted as a Container or a Credential. A Verifiable Container/Credential Registry (VCR) is a type of TEL. It is a form of a Verifiable Data Registry (VDR) that tracks the state of ACDCs issued by the Controller of the KEL. Without loss of specificity, in this section, a TEL serving the purpose of a VCR may be simply denoted as a Registry. A Registry that tracks the dynamic issuance revocation state of an ACDC is called a Revocation Registry.

### Blindable state registry

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/32
:::

In some applications, it is desirable that the current state of an ACDC be hidden or blinded such that the only way for a potential Validator of the state to observe that state is when the Controller of some AID, when acting as Discloser, discloses the state at the time of presentation of that ACDC. This makes the associated TEL a blindable state registry. This is a type of private registry. To clarify, the Issuer designates some AID as the Discloser. Typically, for ACDCs with an Issuee, the Discloser is the Issuee, but the Issuer could designate any AID as the Discloser. Only the Discloser can unblind the state to a potential Disclosee.

In a blindable state Registry, usually, disclosure of the state by Discloser to Disclosee is interactive. A Disclosee may only observe the state when first unblinded in an interactive exchange with the Discloser. After disclosure, the Discloser may then request that the Issuer update the state with a new blinding factor (the blind). The Disclosee cannot then observe the current state of the TEL without yet another disclosure interaction with the Discloser.

The blind is derived from a secret salt shared between the Issuer and the designated Discloser. The current blind is deterministically derived from this salt and the sequence number of the transaction event. This is used to blind the state of the event. To elaborate, the hierarchically deterministic derivation path for the blind is the sequence number of the TEL event, which, combined with the salt, produces a universally unique salty nonce (UUID) to act as the blind. The Issuer publishes the transaction event with a blinded state so that a Validator can independently verify the Issuer's commitment to that state but without being able to determine the state via a seal in the Issuer's KEL with the SAID of that event. Only the Issuer can change the actual blinded state. Only the Issuer and Discloser have a copy of the secret salt, so only they can independently derive the current blind from the sequence number. Given the blind and a small finite number of possible values for the transaction state, the Discloser can verifiably discover and hence unblind the current transaction state from the published SAID of the current transaction event, its sequence number, and the shared secret salt. 

The Issuer may provide an authenticated service endpoint for the Discloser to which the Discloser can make a signed request to update the blind.  Each new event published by the Issuer in the Registry shall increment the sequence number and hence the blinding factor but may or may not change the actual blinded state.  Because each updated event in the Registry has a new blinding factor regardless of an actual change of state or not, an observer cannot correlate state to event updates.

A blindabe state Registry may be used in an unblinded fashion. The Issuer could just publish the state unblinded. This makes is a public Registry. Consequently, a blindable state Registry is generic. It may be used in either a private or public manner.