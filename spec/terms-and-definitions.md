## Terms and Definitions
<!-- file name: terms-and-definitions.md -->
For the purposes of this document, the following terms and definitions apply.

ISO and IEC maintain terminological databases for use in standardization at the following addresses:

 - ISO Online browsing platform: available at <https://www.iso.org/obp>
 - IEC Electropedia: available at <http://www.electropedia.org/>

[[def: Attribute]]

~ a top-level field map within an ACDC that provides a property of an entity that is inherent or assigned to the entity.

[[def: Autonomic Identifier, AID]]

~ a self-managing cryptonymous identifier that must be self-certifying (self-authenticating) and must be encoded in CESR as a qualified Cryptographic Primitive.

[[def: Chain-link Confidential Disclosure]]

~ contractual restrictions and liability imposed on a recipient of a disclosed ACDC that contractually link the obligations to protect the disclosure of the information contained within the ACDC to all subsequent recipients as the information moves downstream. The Chain-link Confidential Disclosure provides a mechanism for protecting against unpermissioned exploitation of the data disclosed via an ACDC.

[[def: Compact Disclosure]]

~ a disclosure of an ACDC that discloses only the SAID(s) of some or all of its field maps. Both Partial and Selective Disclosure rely on Compact Disclosure.

[[def: Contractually Protected Disclosure]]

~ a discloser of an ACDC that leverages a Graduated Disclosure so that contractual protections can be put into place to minimize the leakage of information that can be correlated. A Contractually Protected Disclosure partially or selectively reveals the information contained within the ACDC in the initial interaction with the recipient and disclose further information only after the recipient agrees to the terms established by the discloser. More information may be progressively revealed as the recipient agrees to additional terms.

[[def: Controller]]

~ an entity that can cryptographically prove the control authority over an AID and make changes on the associated KEL. A controller of a multi-sig AID may consist of multiple controlling entities. See [controller](https://trustoverip.github.io/tswg-keri-specification/#term:controller).

[[def: Disclosee]]

~ a role of an entity that is a recipient to which an ACDC is disclosed. A Disclosee may or may not be the Issuee of the disclosed ACDC.

[[def: Discloser]]

~ a role of an entity that discloses an ACDC. A Discloser may or may not be the Issuer of the disclosed ACDC.

[[def: Duplicity]]

~ the existence of more than one Version of a Verifiable KEL for a given AID. See [duplicity](https://trustoverip.github.io/tswg-keri-specification/#term:duplicity).

[[def: Edge]]

~ a top-level field map within an ACDC that provides edges that connect to other ACDCs, forming a labeled property graph (LPG).

[[def: Framing Code]]

~ a code that delineate a number of characters or bytes, as appropriate, that can be extracted atomically from a [[ref: Stream]].

[[def: Full Disclosure]]

~ a disclosure of an ACDC that discloses the full details of some or all of its field maps. In the context of Selective Disclosure, Full Disclosure means detailed disclosure of the selectively disclosed attributes, not the detailed disclosure of all selectively disclosable attributes. In the context of Partial Disclosure, Full Disclosure means detailed disclosure of the field map that was so far only partially disclosed.

[[def: Graduated Disclosure]]

~ a disclosure of an ACDC that does not to reveal its entire content in the initial interaction with the recipient and, instead, partially or selectively reveal only the information contained within the ACDC that is necessary to further a transaction with the recipient. A Graduated disclosure may invole multiple steps where more information is prgressively revealed as the recipient satisfy the conditions set by the discloser. Compact disclosure, Partial disclosure, Selective disclosure and Full disclosure are all Graduated disclosure mechanisms.

[[def: Inception event]]

~ an Establishment event that provides the incepting information needed to derive an AID and establish its initial Key state. See [inception event](https://trustoverip.github.io/tswg-keri-specification/#term:inception-event).

[[def: Information theoretic security, ITPS]]

~ the highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key).

[[def: Interaction event]]

~ a Non-establishment event that anchors external data to the Key state as established by the most recent prior Establishment event. See [interaction event](https://trustoverip.github.io/tswg-keri-specification/#term:interaction-event).

[[def: Issuee]]

~ a role of an entity to which the claims of an ACDC are asserted.

[[def: Issuer]]

~ a role of an entity that asserts claims and creates an ACDC from these claims.

[[def: Key-state]]

~ a set of currently authoritative keypairs for an AID and any other information necessary to secure or establish control authority over an AID. This includes current keys, prior next key digests, current thresholds, prior next thresholds, witnesses, witness thresholds, and configurations. A key-state of an AID is first established through an inception event and may be altered by subsequent rotation events. See [validator](https://trustoverip.github.io/tswg-keri-specification/#term:key-state).

[[def: Operator]]

~ an optional field map in the Edge section that enables expression of the edge logic on edge subgraph as either a unary operator on the edge itself or an m-ary operator on the edge-group.

[[def: Partial Disclosure]]

~ a disclosure of an ACDC that partially discloses its field maps using Compact Disclosure. The Compact Disclosure provides a cryptographically equivalent commitment to the yet-to-be-disclosed content, and later exchange of the uncompacted content is verifiable to an earlier Partial Disclosure. Unlike Selective dDsclosure, a partially disclosable field becomes correlatable to its encompassing block after its Full Disclosure.

[[def: Percolated discovery]]

~ a discovery mechanism for information associated with an AID or a SAID, which is based on Invasion Percolation Theory. Once an entity has discovered such information, it may in turn share what it discovers with other entities. Since the information so discovered is end-verifiable, the percolation mechanism and percolating intermediaries do not need to be trusted.

[[def: Perfect security]]

~ a special case of Information theoretic security [[ref: ITPS]]

[[def: Primitive, Primitives]]

~ a serialization of a unitary value.  All Primitives in KERI must be expressed in CESR.

[[def: Rotation event]]

~ an Establishment Event that provides the information needed to change the Key state which includes a change to the set of authoritative keypairs for an AID. See [rotation event](https://trustoverip.github.io/tswg-keri-specification/#term:rotation-event).

[[def: Rules]]

~ a top-level field map within an ACDC that provides a legal language as a Ricardian Contract [[43]], which is both human and machine-readable and referenceable by a cryptographic digest.

[[def: SEMVER]]

~ Semantic Versioning Specification 2.0. See also (https://semver.org)[https://semver.org]

[[def: Schema]]

~ the SAID of a JSON schema that is used to issue and verify an ACDC.

[[def: Selective Disclosure]]

~ a disclosure of an ACDC that selectively discloses its attributes using Compact Disclosure. The set of selectively disclosable attributes is provided as an array of blinded blocks where each attribute in the set has its own dedicated blinded block. Unlike Partial Disclosure, the selectively disclosed fields are not correlatable to the so far undisclosed but selectively disclosable fields in the same encompassing block.

[[def: Self-Addressing Identifier (SAID), SAID]]

~ any identifier which is deterministically generated out of the content, digest of the content.

[[def: Stream]]

~ a CESR Stream is any set of concatenated Primitives, concatenated groups of Primitives or hierarchically composed groups of [[ref: Primitives]].

[[def: Targeted ACDC]]

~ an ACDC with the presence of the Issuee field in the attribute or attribute aggregate sections.

[[def: Unpermissioned correlation]]

~ a correlation established between two or more disclosed ACDCs whereby the discloser of the ACDCs does not permit the disclosee to establish such a correlation.

[[def: Untargeted ACDC]]

~ an ACDC without the presence of the Issuee field in the attribute or attribute aggregate sections.

[[def: Validator]]

~ any entity or agent that evaluates whether or not a given signed statement as attributed to an identifier is valid at the time of its issuance. See [validator](https://trustoverip.github.io/tswg-keri-specification/#term:validator).

[[def: Verifiable data registry]]

~ A role a system might perform by mediating issuance and verification of ACDCs. See [verifiable data registry](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifiable-data-registries).

[[def: Verifier]]

~ any entity or agent that cryptographically verifies the signature(s) and/or digests on an event Message. See [verifier](https://trustoverip.github.io/tswg-keri-specification/#term:verifier).

[[def: Weight]]

~ an optional field map in the Edge section that provides edge weight property that enables directed weighted edges and operators that use weights.

[//]: # (ACDC fields  {#sec:content})

