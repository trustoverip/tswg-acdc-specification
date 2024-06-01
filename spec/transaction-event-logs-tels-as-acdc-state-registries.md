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


#### Message types

Blindable state registries have two types of events. These types are shown in the following table:

|Ilk| Name | Description|
|---|---|---|
|`rip`| Registry Inception | registry initialization |
|`upd`| Update | transaction event state update |

In some cases, the usage of the registry may provide correlatable information, as would be the case where the first real transaction state is always the same or the final state results in the disuse of the Registry. In those cases, the Issuer may choose to define an empty (null) state and an empty (null) ACDC SAID as known placeholder values. The first transaction state update event in the Registry can, therefore, be published before any real ACDC has been created, to which it may be later applied. Disuse of the Registry can be hidden by continuing to update the blind to the state without changing the final state value for some time after the ACDC has been revoked or abandoned. 


#### Top-level fields

The reserved field labels for the top level of a blindable state registry transaction event are as follows:

|Label|Description|
|---|---|---|
|`v`| Version String |
|`t`| Message type |
|`d`| event block SAID |
|`u`| UUID salty nonce |
|`i`| Issuer AID |
|`r`| Registry SAID|
|`s`| sequence number|
|`p`| prior event SAID |
|`dt`| Issuer relative ISO date/time string |
|`a`| state Attribute block or Attribute block SAID|

#### Init event fields

The fields for the Init, `rip` event , given by their labels, shall appear in the following order, `[v, t, d, u, i, s, dt]`. All are required. The value of the Message type, `t` field shall be `rip`. The value of the sequence number field, `s` shall be the hex encoded string for the integer 0. 

#### Update event fields

The fields for the Update, `upd` event , given by their labels, shall appear in the following order, `[v, t, d, r, s, p, dt, a]`. All are required. The value of the Message type, `t` field shall be `upd`. 

#### Field descriptions

##### Version String, `v` field

The Version String, `v` field value uses the same format as an ACDC Version String {{see above}}. The protocol type shall be `ACDC`.

##### Message type, `t` field

The Message type, `t` field value shall be  one of the Message types in the table above. The Message types do not leak any state information. The first Message in some types of Registries such as an issuance/revocation Registry.

##### SAID, `d` field

The SAID, `d` field value shall be the SAID of its enclosing block. A transaction event's SAID enables a verifiable globally unique reference to that event.

##### UUID, `u` field
The UUID, `u` field value shall be a cryptographic strength salty nonce with approximately 128 bits of entropy. The UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[48]]. An adversary, when given both the block's SAID and knowledge of all possible state values, cannot discover the actual state in a computationally feasible manner, such as a rainbow table attack [[30]] [[31]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's structure, possible state values, and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's state unless and until there has been a disclosure of that state.

##### Issuer, `i` field

The Issuer, `i` field value shall be the AID of the Issuer. This removes any ambiguity about the semantics of a seal of a transaction event that appears in a KEL. When the KEL controller AID and Issuer AID are the same for a transaction event seal that appears in a given KEL, then the KEL Controller is making a commitment as Issuer to the transaction event. A transaction event seal that appears in a KEL with a different Controller AID is merely a nonrepudiable endorsement of the transaction state by some other party, not a duplicity-evident nonrepudiable commitment by the Issuer to the transaction state. This may appear to be redundant because the Issuer AID also appears in the ACDC. In a blinded state Registry, however, the ACDC SAID only appears in the blinded Attribute block likewise in a yet-to-be-disclosed private ACDC, the Issuer is also blinded, so a Registry observer that hosts a copy of the Registry that is not also a Disclosee of either the expanded transaction event and/or the associated ADCD would not be able to confirm that commitment and may thereby be subject to a DDoS attack without the presence of the Issuer, `i` field in the Registy initialization event's public top-level fields.

##### Registry SAID, `r` field

The Registry SAID, `r` field value shall be the value of the SAID, `d` field of the Registry Inception, `rip` event. Because the Issuer, `i` field appears in the `rip` event, the Registry SAID, `r` field value cryptographically binds the Registry to the Issuer AID. The Registry SAID enables a verifiable globally unique reference to the Registry (TEL). Update events shall include the Registry SAID, `r` field so that they can be easily associated with the Registry (TEL). The ACDC managed by the Registry also includes a reference to the Registry in the ADCD's own Registry SAID, `rd` field, thereby binding the ACDC to the Registry. To clarify the value of the Registry SAID, `r` field in transaction events is the same value as the corresponding Registry SAID, `rd` field in the associated ACDC.

##### Sequence number, `s` field

The sequence number, `s` field value shall be a hex-encoded string with no leading zeros of a zero-based strictly monotonically increasing integer. The first (zeroth) transaction event in a given Registry (TEL) shall have a sequence number of 0 or `0` hex.

##### Prior event SAID, `p` field

The prior event SAID, `p` field value shall be the SAID, `d` field value of the immediately prior event in the TEL. The prior, `p` field backward chains together the events in a given TEL.

##### Datetime, `dt` field

The datetime, `dt` field value shall be the ISO-8601 datetime string with microseconds and UTC offset as per IETF RFC-3339. This shall be the datetime of the issuance of the transaction event relative to the clock of the issuer. An example datetime string in this format is as follows:

`2020-08-22T17:50:09.988921+00:00`

##### Attribute, `a` field

The Attribute, `a` field value shall be the SAID of the blinded Attribute block when used in a blinded (private) fashion. Alternatively, when used in an unblinded (public) fashion, the Attribute, `a` field value shall be either the fully expanded Attribute block (field map) or the SAID of the Attribute block but without its UUID, `u` field. See below for a description of the expanded Attribute block.

#### Expanded attribute block

The expanded Attribute block has the following fields:

|Label|Description|
|---|---|---|
|d| Attribute block SAID |
|u| UUID salty nonce blinding factor, random or HD generated |
|ts| transaction state value string | 

The fields shall appear in the following order `[d, u, ts]`. When used in private (blinded) mode, all are required. When used in public (unblinded) mode, the SAID, `d` field is optional, the UUID, `u` field is not allowed, the transaction state, `ts` field is required.

##### SAID, `d` field

The SAID, `d` field value shall be the SAID of its enclosing block. An Attribute section's SAID enables a verifiable globally unique reference to that state contained in the block but without necessarily disclosing that state.

##### UUID, `u` field

The UUID, `u` field value shall be a cryptographic strength salty nonce with approximately 128 bits of entropy. The UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[48]]. An adversary, when given both the block's SAID and knowledge of all possible state values, cannot discover the actual state in a computationally feasible manner, such as a rainbow table attack [[30]] [[31]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's structure, possible state values, and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's state unless and until there has been a disclosure of that state.

When the UUID, `u`, is derived from a shared secret salt and a public path such as the sequence number using a hierarchically deterministic derivation algorithm and given that the possible state values are finite and small, then any holder of the shared secret can derive the state given the public information in the top-level fields of the transaction event.

##### Transaction state, `ts` field

The transaction state, `ts` field value shall be a string from a small finite set of strings that delimit the possible values of the transaction state for the Registry. For example, the state values for an issuance/revocation registry may be `issued` or `revoked`.

#### Private (blinded) state Registry example

Consider a blindable state revocation registry for ACDCs operated in blinded (private) mode. The transaction state can be one of two values, `issued`, or `revoked`. In this case, the placeholder value of the empty, `` string for transaction state, `ts` field is also employed to decorrelate the initialization.  The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```

With respect to the event above, given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere. This value is derived from the Issuer AID, binding the Registry to the Issuer AID. When this Registry identifier value is included in the Registry SAID, `rd` field of an ACDC, this binds that ACDC to the Registry.

The state is initialized with decorrelated placeholder values with the issuance of the following placeholder update event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```

Notice in the event above that the registry SAID, `r` field value matches the value of the SAID, `d` field in the Registry Inception, `rip` event. 

The associated expanded Attribute block is as follows:

```json
{
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "u": "ZHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "ts": ""
}
```

Notice that the value of the attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded attribute block. In this case, the value of the transaction state, the `ts` field, is just an empty string as a placeholder value. The transaction state may not yet correspond to a real ACDC.  The blind for this placeholder attribute block may be updated any number of times prior to its first use as the true state of a real ACDC. This makes the first use(s) of the registry uncorrelated to the actual issuance of the real ACDC. 

Suppose that the Discloser has been given the shared secret salt from which the value of the blind, UUID, `u` field was generated. The Discloser can then download the published transaction event to get the sequence number, `s` field value. With that value and the shared secret salt, the Discloser can regenerate the blind UUID, `u` field value. The Discloser also knows the real ACDC that will be used for this Registry. Consequently, it knows that the value of the ACDC, SAID, `d` field must be either the empty string placeholder or the real ACDC SAID. The Discloser can now compute the SAID, `d` field value of the expanded Attribute block for either the empty placeholder value of the `ts` field or with one of the two possible state values, namely, `issued` or `revoked` for the `ts` field. This gives three possibilities. The Discloser tries each one until it finds the one that matches the published transaction event Attribute, `a` field value. The Discloser can then verify if the published value is still a placeholder or the real initial state.

Sometime later, the real ACDC is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the registry SAID, `rd` field of that ACDC will be the registry SAID given by the value of the SAID, `d` field in the registry inception, `rip` event. This binds the ACDC to the Registry.

Suppose the associated update event occurs at sequence number 5. The published transaction event is as follows:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "5",
 "p": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```

The associated expanded Attribute block is as follows:

```json
{
 "d": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-",
 "u": "ZIZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PL",
 "ts": "issued"
}
```

Notice that the value of the Attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded Attribute block. Notice further that in this case, the value of the transaction state, `ts` field, is `issued` (not the empty placeholder).  Suppose that the Discloser has been given the shared secret salt from which the value of the blind, UUID, `u` field was generated. The Discloser can then download the published transaction event to get the sequence number, `s` field value. With that value and the shared secret salt, the Discloser can regenerate the blind UUID, `u` field value. The Discloser also knows which ACDC it wishes to disclose so it also has the ACDC, SAID, `d` field value. The Discloser can now compute the SAID, `d` field value of the expanded Attribute block for either the empty placeholder value or with one of the two possible state values, namely, `issued` or `revoked` for the `ts` field. This gives three possibilities. The Discloser tries each one until it finds the one that matches the published transaction event Attribute, `a` field value. The Discloser can then disclose the matching expanded Attribute block to the Disclosee, who can verify it against the published transaction event.

The Discloser can then instruct the Issuer to issue one or more updates with new blinding factors so that the initial Disclosee may no longer validate the state of the ACDC without another interactive disclosure by the Discloser.

Suppose at some later time, a Validator requires that the Discloser provide continuing proof of issuance. In that case, the Discloser would disclose the current state of the Registry. Suppose it has been revoked. The Discloser may either refuse to disclose (with the associated consequences) or may only verifiably disclose the true state. Suppose this is at sequence number 9 as follows:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "9",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI"
}
```

The associated expanded Attribute block is as follows: 

```json
{
 "d": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI",
 "u": "ZNoRxCJp2wIGM9u2Edk-PLIZ1H4zpq06UecHwzy-K9Fp",
 "ts": "revoked"
}
```

The Discloser could continue to have the blind updated periodically. This would generate new transaction events with new values for its Attribute, `a` field, but without changing the transaction state field value. This decorrelates the time of revocation with respect to the latest event in the Registry.

#### Public (unblinded) state Registry example 

Consider a blindable state revocation Registry for ACDCs operated in an unblinded (public) mode. The transaction state can be one of two values, `issued`, or `revoked`. The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```
With respect to the event above, given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere.

Sometime later, an ACDC is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the registry SAID, `rd` field of that ACDC will be the value given by the value of the SAID, `d` field in the registry inception, `rip` event. This binds the ACDC to the Registry.

The state is initialized with the following update event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```
Notice in the event above that the registry SAID, `r` field value matches the value of the SAID, `d` field in the Registry Inception, `rip` event. 

The associated expanded Attribute block is as follows:

```json
{
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "ts": "issued"
}
```

Notice that the value of the attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded attribute block. Further notice that the UUID, `u` field is missing. This makes the attribute block unblinded. The Issuer may provide an API that allows a Validator to query the attributed block for any given transaction event in the registry, or knowing that it is unblinded, a Validator can try the two different state value possibilities to discover which one generates a SAID, `d` field value that matches the attribute, `a` field value in the event.

Sometime later the ACDC is revoked with the publication by the Issuer of the following event:


```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "2",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI"
}
```

The associated expanded Attribute block is as follows: 

```json
{
 "d": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI",
 "ts": "revoked"
}
```

#### Simple public (unblinded) state Registry example 

Consider a blindable state revocation Registry for ACDCs operated in an unblinded (public) mode. The transaction state can be one of two values, `issued`, or `revoked`. The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```

Given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere as the Registry SAID, `rd` field. The `rd` field value is derived from the Issuer AID, binding the Registry to the Issuer AID. 

Sometime later, an ACDC for this Registry is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the Registry SAID, `rd` field of that ACDC will be the Registry SAID given by the value of the SAID, `d` field in the Registry inception, `rip` event. This binds the ACDC to the Registry.

The state is initialized with the following simple update event:


```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": 
 {
   "ts": "issued"
 }
}
```

Notice that the value of the Attribute, `a` field in the transaction event, is now a field map block, not a SAID string. Further notice that both the SAID, `d`, and UUID, `u` fields are missing as they are now superfluous.

Sometime later, the ACDC is revoked with the publication by the Issuer of the following simple update event:

```json
{
 "v": "ACDCCAAJSONAACQ.",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "r": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "2",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": 
 {
   "ts": "revoked"
 }
}
```
