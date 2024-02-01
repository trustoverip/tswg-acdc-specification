Authentic Chained Data Containers (ACDC)
==================

**Specification Status**: v1.0 Draft

**Latest Draft:**

[https://github.com/trustoverip/tswg-acdc-specification](https://github.com/trustoverip/tswg-acdc-specification)

**Author:**

- [Samuel Smith](https://github.com/SmithSamuelM), [Prosapien](https://prosapien.com/)
- [Philip Feairheller](https://github.com/pfeairheller), [GLEIF](https://gleif.org/)

**Editors:**

**Contributors:**

**Participate:**

~ [GitHub repo](https://github.com/trustoverip/tswg-acdc-specification)
~ [Commit history](https://github.com/trustoverip/tswg-acdc-specification/commits/main)

[//]: # (\maketitle)

[//]: # (\newpage)

[//]: # (\toc)

[//]: # (\newpage)

[//]: # (::: forewordtitle)

## Foreword

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/8
:::

An Authentic chained data container (ACDC) specification [[ref: ACDC]] [[ref: ACDC_WP]] [[ref: VCEnh]] is being incubated at the ToIP (Trust over IP) Foundation [[ref: TOIP]] [[ref: ACDC_TF]].  An ACDC is a compliant external proof format of the W3C VC 2.0 specification.  The ACDC specification supports the use of KERI-based (Key Event Receipt Infrastructure) DID methods such as did:KERI and did:webs as primary identifiers W3C DID (Decentralized Identifier) specification [[ref: W3C_DID]]. A major use case for the ACDC specification is the use of ACDCs as vLEIs (verifiable Legal Entity Identifiers) within the ecosystem and infrastructure developed by[[ref: vLEI]] [[ref: GLEIF_vLEI]] [[ref: GLEIF_KERI]]. the Global Legal Entity Identifier Foundation [[ref: GLEIF]]. An ISO standard for vLEIs currently is under development at the International Organization for Standardization (ISO).  ACDCs are dependent on a suite of related specifications along with the KERI [[ref: KERI]] specification. These include CESR [[ref: CESR]], SAID [[ref: SAID_ID]], did:keri [[ref: DIDK_ID]], and OOBI [[ref: OOBI]]. Some of the major distinguishing features of ACDCs include normative support for chaining, use of composable JSON Schema [[ref: JSch]] [[ref: JSchCp]], multiple serialization formats, namely, JSON [[ref: JSON]] [[ref: RFC4627]], CBOR [[ref: CBOR]] [[ref: RFC8949]], MGPK [[ref: MGPK]], and CESR [[ref: CESR]], support for Ricardian contracts [[ref: RC]],  support for chain-link confidentiality [[ref: CLC]], a well-defined security model derived from KERI [[ref: KERI]],Compact formats for resource constrained applications, simple Partial disclosure mechanisms and simple Selective disclosure mechanisms. ACDCs provision data using a synergy of provenance, protection, and performance.


[//]: # (:::)

[//]: # (\newpage)

[//]: # (::: introtitle)

## Introduction

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/11
:::

One primary purpose of the ACDC protocol is to provide granular provenanced proof-of-authorship (authenticity) of their contained data via a tree or chain of linked ACDCs (technically a directed acyclic graph or DAG). Similar to the concept of a chain-of-custody, ACDCs provide a verifiable chain of proof-of-authorship of the contained data. This could enable an "authentic" web where all data on the web has verifiable proof-of-authorship. 

With a little additional syntactic sugar, this primary facility of chained (treed) proof-of-authorship (authenticity) is extensible to a chained (treed) verifiable authentic proof-of-authority (proof-of-authorship-of-authority). A proof-of-authority may be used to provide different types of verifiable authorizations such as, entitlements, licences, permissions, rights, or credentials. A chained (treed) proof-of-authority enables delegation of authority and hence delegated authorizations. These proofs of authorship and/or authority provide provenance of an ACDC itself and, by association, any data that is so conveyed.

To elaborate, the dictionary definition of credential is "evidence of authority, status, rights, entitlement to privileges, etc."  Appropriately structured ACDCs may be used as credentials when their semantics provide verifiable evidence of authority. Chained ACDCs may provide delegated credentials.

Chains of ACDCs that merely provide proof-of-authorship (authenticity) of data may be appended to chains of ACDCs that provide proof-of-authority (delegation) to enable verifiable delegated authorized authorship of data.  This is also a vital facility for authentic data supply chains. Furthermore, any physical supply chain may be measured, monitored, regulated, audited, and/or archived by a data supply chain acting as a digital twin [[ref: Twin]]. Therefore, ACDCs provide the critical enabling facility for an authentic data economy and, by association, an authentic real (twinned) economy.

ACDCs act as securely attributed (authentic) fragments of a distributed property graph (PG) [[ref: PGM]] [[ref: Dots]]. Thus, ACDCs may be used to construct knowledge graphs expressed as property graphs [[ref: KG]]. ACDCs enable securely-attributed and privacy-protecting knowledge graphs. Semantically modulated verifiable provenanceable graphs enable authenticatable, delegable, attenuable, and aggregable authorizations and attributions.

The ACDC specification (including its disclosure mechanisms) leverages two primary cryptographic operations, namely digests and digital signatures [[ref: Hash]] [[ref: DSig]]. These operations, when used in an ACDC, must have a security level, cryptographic strength, or entropy of approximately 128 bits [[ref: Level]]. (See the Annex A for a discussion of cryptographic strength and security)

An important property of high-strength cryptographic digests is that a verifiable cryptographic commitment (such as a digital signature) to the digest of some data is equivalent to a commitment to the data itself. The digest enables confidentiality because secure attribution of the commitment to the digest may be verified without disclosing the digested data. Later, confidential disclosure of the digested data can be verified against the digest. ACDCs leverage this property to enable compact chains of ACDCs that commit to (anchor or seal) data via digests. The data actually contained in an ACDC, therefore, may be merely its digest. The digested data may thereby be equivalently but more compactly and confidentially authenticated and authorized by the chain of ACDCs.

There are several different variants of ACDCs. These enable different types of disclosure mechanisms that provide differing levels of protection from exploitation and enable functional privacy with provisional authentication. A notable feature of ACDCs is support for contractually protected disclosure that provides more comprehensive privacy protection than mere selective disclosure alone might provide.


[//]: # (:::)

## Status of This Memo

Information about the current status of this document, any errata,
and how to provide feedback on it, may be obtained at
[https://github.com/trustoverip/tswg-acdc-specification](https://github.com/trustoverip/tswg-acdc-specification).

## Copyright Notice

This specification is subject to the **OWF Contributor License Agreement 1.0 - Copyright**
available at
[https://www.openwebfoundation.org/the-agreements/the-owf-1-0-agreements-granted-claims/owf-contributor-license-agreement-1-0-copyright](https://www.openwebfoundation.org/the-agreements/the-owf-1-0-agreements-granted-claims/owf-contributor-license-agreement-1-0-copyright).

If source code is included in the specification, that code is subject to the
[Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.txt) unless otherwise marked. In the case of any conflict or
confusion within this specification between the OWF Contributor License 
and the designated source code license, the terms of the OWF Contributor License shall apply.

These terms are inherited from the Technical Stack Working Group at the Trust over IP Foundation. [Working Group Charter](https://trustoverip.org/wp-content/uploads/TSWG-2-Charter-Revision.pdf)


## Terms of Use

These materials are made available under and are subject to the [OWF CLA 1.0 - Copyright & Patent license](https://www.openwebfoundation.org/the-agreements/the-owf-1-0-agreements-granted-claims/owf-contributor-license-agreement-1-0-copyright-and-patent). Any source code is made available under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.txt).

THESE MATERIALS ARE PROVIDED “AS IS.” The Trust Over IP Foundation, established as the Joint Development Foundation Projects, LLC, Trust Over IP Foundation Series ("ToIP"), and its members and contributors (each of ToIP, its members and contributors, a "ToIP Party") expressly disclaim any warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to the materials. The entire risk as to implementing or otherwise using the materials is assumed by the implementer and user. 
IN NO EVENT WILL ANY ToIP PARTY BE LIABLE TO ANY OTHER PARTY FOR LOST PROFITS OR ANY FORM OF INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES OF ANY CHARACTER FROM ANY CAUSES OF ACTION OF ANY KIND WITH RESPECT TO THESE MATERIALS, ANY DELIVERABLE OR THE ToIP GOVERNING AGREEMENT, WHETHER BASED ON BREACH OF CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, AND WHETHER OR NOT THE OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[//]: # (\mainmatter)

[//]: # (\doctitle)

## Scope

narrow scope here

## Normative references

[//]: # (::: { #nrm:osi .normref label="ISO/IEC 7498-1:1994" })

[//]: # (ISO/IEC 7498-1:1994 Information technology — Open Systems Interconnection — Basic Reference Model: The Basic Model)

[//]: # (:::)

This document has no normative references.


## Terms and Definitions

For the purposes of this document, the following terms and definitions apply.

ISO and IEC maintain terminological databases for use in standardization at the following addresses:

 - ISO Online browsing platform: available at <https://www.iso.org/obp>
 - IEC Electropedia: available at <http://www.electropedia.org/>

- `SAID` - Self-Addressing Identifier - any identifier which is deterministically generated out of the content, digest of the content

Additional definitions needed for this section 
Information theoretic security [[ref: ITPS]] The highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key).
Perfect security – a special case of Information theoretic security [[ref: ITPS]]
One-time-pad (OTP)(also called a Vernum Cipher OTP) [[ref: VCphr]]
Secret splitting [[ref: SSplt]] a type of secret sharing [[ref: SShr]] that uses the same technique as an OTP.

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/36
:::

[[def: Compact disclosure]]

~ a disclosure of an ACDC that discloses only the SAID(s) of some or all of its field maps. Both partial and selective disclosure rely on compact disclosure.

[[def: Partial disclosure]]

~ a disclosure of an ACDC that partially discloses its field maps using compact disclosure. The compact disclosure provides a cryptographically equivalent commitment to the yet-to-be-disclosed content, and later exchange of the uncompacted content is verifiable to an earlier partial disclosure. Unlike Selective disclosure, a partially disclosable field becomes correlatable to its encompassing block after its Full disclosure.

[[def: Selective disclosure]]

~ a disclosure of an ACDC that selectively discloses its attributes using compact disclosure. The set of selectively disclosable attributes is provided as an array of blinded blocks where each attribute in the set has its own dedicated blinded block. Unlike Partial disclosure, the selectively disclosed fields are not correlatable to the so far undisclosed but selectively disclosable fields in the same encompassing block.

[[def: Full disclosure]]

~ a disclosure of an ACDC that discloses the full details of some or all of its field maps. In the context of Selective disclosure, Full disclosure means detailed disclosure of the selectively disclosed attributes, not the detailed disclosure of all selectively disclosable attributes. In the context of Partial disclosure, Full disclosure means detailed disclosure of the field map that was so far only partially disclosed.

[[def: Graduated disclosure]]

~ a disclosure of an ACDC that does not to reveal its entire content in the initial interaction with the recipient and, instead, partially or selectively reveal only the information contained within the ACDC that is necessary to further a transaction with the recipient. A Graduated disclosure may invole multiple steps where more information is prgressively revealed as the recipient satisfy the conditions set by the discloser. Compact disclosure, Partial disclosure, Selective disclosure and Full disclosure are all Graduated disclosure mechanisms. 

[[def: Contractually protected disclosure]]

~ a discloser of an ACDC that leverages a Graduated disclosure so that contractual protections can be put into place to minimize the leakage of information that can be correlated. A Contractually protected disclosure partially or selectively reveal the information contained within the ACDC in the initial interaction with the recipient and disclose further information only after the recipient agrees to the terms established by the discloser. More information may be progressively revealed as the recipient agrees to additional terms.

[[def: Chain-link confidential disclosure]]

~ contractual restrictions and liability imposed on a recipient of a disclosed ACDC that contractually link the obligations to protect the disclosure of the information contained within the ACDC to all subsequent recipients as the information moves downstream. The Chain-link confidential disclosure provides a mechanism for protecting against unpermissioned exploitation of the data disclosed via an ACDC.

[[def: Discloser]] 

~ a role of an entity that discloses an ACDC. A Discloser may or may not be the Issuer of the disclosed ACDC.

[[def: Disclosee]]

~ a role of an entity that is a recipient to which an ACDC is disclosed. A Disclosee may or may not be the Issuee of the disclosed ACDC.

[[def: Issuer]]

~ a role of an entity that asserts claims and creates an ACDC from these claims. 

[[def: Issuee]]

~ a role of an entity to which the cliams of an ACDC are asserted.

[[def: Controller]]

~ an entity that can cryptographically prove the control authority over an AID and make changes on the associated KEL. A controller of a multi-sig AID may consist of multiple controlling entities. See [controller](https://trustoverip.github.io/tswg-keri-specification/#term:controller).

[[def: Verifier]]

~ any entity or agent that cryptographically verifies the signature(s) and/or digests on an event Message. See [verifier](https://trustoverip.github.io/tswg-keri-specification/#term:verifier).

[[def: Validator]]

~ any entity or agent that evaluates whether or not a given signed statement as attributed to an identifier is valid at the time of its issuance. See [validator](https://trustoverip.github.io/tswg-keri-specification/#term:validator).

[[def: Key-state]]

~ a set of currently authoritative keypairs for an AID and any other information necessary to secure or establish control authority over an AID. This includes current keys, prior next key digests, current thresholds, prior next thresholds, witnesses, witness thresholds, and configurations. A key-state of an AID is first established through an inception event and may be altered by subsequent rotation events. See [validator](https://trustoverip.github.io/tswg-keri-specification/#term:key-state).

[[def: Rotation event]]

~ an Establishment Event that provides the information needed to change the Key state which includes a change to the set of authoritative keypairs for an AID. See [rotation event](https://trustoverip.github.io/tswg-keri-specification/#term:rotation-event).

[[def: Interaction event]]

~ a Non-establishment event that anchors external data to the Key state as established by the most recent prior Establishment event. See [interaction event](https://trustoverip.github.io/tswg-keri-specification/#term:interaction-event).

[[def: Inception event]]

~ an Establishment event that provides the incepting information needed to derive an AID and establish its initial Key state. See [inception event](https://trustoverip.github.io/tswg-keri-specification/#term:inception-event).

[[def: Verifiable data registry]]

~ A role a system might perform by mediating issuance and verification of ACDCs. See [verifiable data registry](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifiable-data-registries).

[[def: Duplicity]]

~ the existence of more than one Version of a Verifiable KEL for a given AID. See [duplicity](https://trustoverip.github.io/tswg-keri-specification/#term:duplicity).

[[def: Attribute]]

~ a top-level field map within an ACDC that provides a property of an entity that is inherent or assigned to the entity.
 
[[def: Targeted ACDC]]

~ an ACDC with the presence of the Issuee field in the attribute or attribute aggregate sections.

[[def: Untargeted ACDC]]

~ an ACDC without the presence of the Issuee field in the attribute or attribute aggregate sections.

[[def: Operator]]

~ an optional field map in the Edge section that enables expression of the edge logic on edge subgraph as either a unary operator on the edge itself or an m-ary operator on the edge-group.

[[def: Weight]]

~ an optional field map in the Edge section that provides edge weight property that enables directed weighted edges and operators that use weights.

[[def: Unpermissioned correlation]]

~ a correlation established between two or more disclosed ACDCs whereby the discloser of the ACDCs does not permit the disclosee to establish such a correlation.

[[def: Percolated discovery]]

~ a discovery mechanism for information associated with an AID or a SAID, which is based on Invasion Percolation Theory. Once an entity has discovered such information, it may in turn share what it discovers with other entities. Since the information so discovered is end-verifiable, the percolation mechanism and percolating intermediaries do not need to be trusted.

[[def: Rules]]

~ a top-level field map within an ACDC that provides a legal language as a Ricardian Contract [[ref: RC]], which is both human and machine-readable and referenceable by a cryptographic digest. 

[[def: Edge]]

~ a top-level field map within an ACDC that provides edges that connect to other ACDCs, forming a labeled property graph (LPG).

[[def: Schema]]

~ the SAID of a JSON schema that is used to issue and verify an ACDC.

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/16
:::

Derived Identifier

Disclosure
Disclosee
Discloser

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/19
:::

Simple Grant Language

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/25
:::

[//]: # (ACDC fields  {#sec:content})



## ACDC Structure

### Ordered nested field maps

An ACDC may be modeled abstractly as a nested `key: value` mapping. To avoid confusion with the cryptographic use of the term key,  the term field is used instead to refer to a mapping pair and the terms field label and field value for each member of a pair. These pairs can be represented by two tuples e.g., `(label, value)`. This terminology can be qualified, when necessary, by using the term field map to reference such a mapping. Field maps may be nested where a given field value is itself a reference to another field map. A nested set of fields is called a nested field map or simply a nested map for short. 

A field may be represented by a Framing code or block delimited serialization.  In a block delimited serialization, such as JSON, each field map is represented by an object block with block delimiters such as `{}` [[ref: RFC8259]] [[ref: JSON]] [[ref: RFC4627]]. Given this equivalence, the term block or nested block also may be used as synonymous with field map or nested field map. In many programming languages, a field map is implemented as a dictionary or hash table in order to enable performant asynchronous lookup of a field value from its field label. Reproducible serialization of field maps requires a canonical ordering of those fields. One such canonical ordering is called insertion or field creation order. A list of `(field, value)` pairs provides an ordered representation of any field map. Most programming languages now support ordered dictionaries or hash tables that provide reproducible iteration over a list of ordered field `(label, value)` pairs where the ordering is the insertion or field creation order. This enables reproducible round-trip serialization/deserialization of field maps.  ACDCs depend on insertion ordered field maps for canonical serialization/deserialization. ACDCs support multiple serialization types, namely JSON, CBOR, MGPK, and CESR but for the sake of simplicity, JSON only will be used for examples [[ref: RFC8259]] [[ref: JSON]]. The basic set of normative field labels in ACDC field maps is defined in the following table.


### Top-Level fields
::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/12
:::


::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/13
:::

The following table defines the top-level fields in an ACDC and their order of appearance. Some fields are optional but all fields that appear must appear in a defined order.

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: ACDCvvSSSShhhhhh_ that provides protocol type, version, serialization type, size, and terminator. |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Issuer Identifier (AID)| Autonomic Identifier whose control authority is established via KERI verifiable key state. |
|`rd`| Registry Digest (SAID) | Issuance and/or revocation, transfer, or retraction registry for ACDC |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of edges or the block itself.|
|`r`| Rule | Either the SAID a block of rules or the block itself. |

#### Field ordering

When present, the top-level fields shall appear in the following order: `[v, d, u, i, rd, s, a, A, e, r]`. 

#### Required fields

The following fields are required `[v, d, i, s]`. One and only one of the following two fields is also required: `[a, A]`.


### Other reserved fields

The following table defines non-top-level fields whose labels are reserved. 
These appear at other levels besides the top-level of an ACDC. 

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Identifier (AID)| Context dependent AID as determined by its enclosing map such as Issuee identifier. |
|`n`| Node| SAID of another ACDC as the terminating point (vertex) of a directed edge that connects the encapsulating ACDC node to the specified ACDC node as a fragment of a distributed property graph (PG).|
|`o`| Operator| Either unary operator on edge or m-ary operator on edge-group in edge section. Enables expressing of edge logic on edge subgraph.|
|`w`| Weight| Edge weight property that enables default property for directed weighted edges and operators on directed weighted edges.|
|`l`| Legal Language| Text of Ricardian contract clause.|

### Compact labels

The primary field labels are compact in that they use only one or two characters. ACDCs are meant to support resource-constrained applications such as supply chain or IoT (Internet of Things) applications. Compact labels better support resource-constrained applications in general. With compact labels, the over-the-wire verifiable signed serialization consumes a minimum amount of bandwidth. Nevertheless, without loss of generality, a one-to-one normative semantic overlay using more verbose expressive field labels may be applied to the normative compact labels after verification of the over-the-wire serialization. This approach better supports bandwidth and storage constraints on transmission while not precluding any later semantic post-processing. This is a well-known design pattern for resource-constrained applications.

### Version string field

The version string, `v`, field shall be the first field in any top-level ACDC field map encoded in JSON, CBOR, or MGPK as a message body [[spec: RFC4627]] [[spec: RFC4627]] [[ref: CBOR]] [[ref: RFC8949]] [[ref: MGPK]]. It provides a regular expression target for determining a serialized field map's serialization format and size (character count) constituting an ACDC message body. A stream parser may use the version string to extract and deserialize (deterministically) any serialized stream of ACDC message bodies. Each ACDC message body in a stream may use a different serialization type. The format for the version string field value is defined in the CESR specification [[ref: CESR]]. 

The protocol field, `PPPP` value in the version string shall be `ACDC` for the ACDC protocol. The version field, `VVV`, shall encode the current version of the ACDC protocol [[ref: CESR]].

##### Legacy version string field format

Compliant ACDC version 2.XX implementations shall support the old ACDC version 1.x version string format to properly verify message bodies created with 1.x format events. The old version 1.X version string format is defined in the CESR specification [[ref: CESR]]. The protocol field, `PPPP` value in the version string shall be `ACDC` for the ACDC protocol. The version field, `vv`, shall encode the old version of the ACDC protocol [[ref: CESR]].


### Self-addressing identifier (SAID) fields

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/14
:::

Some fields in ACDCs may have for their value either a field map or a SAID. A SAID follows the SAID protocol [[ref: SAID]]. Essentially, a SAID is a Self-addressing identifier (self-referential content addressable). A SAID is a special type of cryptographic digest of its encapsulating field map (block). The encapsulating block of a SAID is called a SAD (Self-addressed data). Using a SAID as a field value enables a more compact but secure representation of the associated block (SAD) from which the SAID is derived. Any nested field map that includes a SAID field (i.e., is, therefore, a SAD) may be compacted into its SAID. The uncompacted blocks for each associated SAID may be attached or cached to optimize bandwidth and availability without decreasing security.

Several top-level ACDC fields may have for their value either a serialized field map or the SAID of that field map. Each SAID provides a stable, universal, cryptographically verifiable, and agile reference to its encapsulating block (serialized field map). These include the `d`, and `rd` fields. Moreover, the value of top-level `s`, `a`, `e`, and `r` fields may be replaced by the SAID of their associated field map. When replaced by their SAID, these top-level sections are in compact form.

Recall that a cryptographic commitment (such as a digital signature or cryptographic digest) on a given digest with sufficient cryptographic strength, including collision resistance [[ref: HCR]] [[ref: QCHC]], is equivalent to a commitment to the block from which the given digest was derived.  Specifically, a digital signature on a SAID makes a verifiable cryptographic non-repudiable commitment that is equivalent to a commitment on the full serialization of the associated block from which the SAID was derived. This enables reasoning about ACDCs in whole or in part via their SAIDS in a fully interoperable, verifiable, compact, and secure manner. This also supports the well-known bow-tie model of Ricardian Contracts [[ref: RC]]. This includes reasoning about the whole ACDC given by its top-level SAID, `d`, field, as well as reasoning about any nested sections using their SAIDS.

### Registry SAID field

When present, the registry SAID, `rd` field value is the SAID of the initializing event for a given transaction event log (TEL) registry that maintains a dynamic state for the ACDC, such as issuance and revocation state. 


### Universally unique identifier (UUID) fields

The purpose of the UUID, `u`, field in any block is to provide sufficient entropy to the SAID, `d`, field of the associated block to make computationally infeasible any brute force attacks on that block that attempt to discover the block contents from the schema and the SAID. The UUID, `u`, field may be considered a salty nonce [[ref: Salt]]. Without the entropy provided the UUID, `u`, field, an adversary may be able to reconstruct the block contents merely from the SAID of the block and the schema of the block using a rainbow or dictionary attack on the set of field values allowed by the schema [[ref: RB]] ][[ref: DRB]]. The effective security level, entropy, or cryptographic strength of the schema-compliant field values may be much less than the cryptographic strength of the SAID digest. Another way of saying this is that the cardinality of the power set of all combinations of allowed field values may be much less than the cryptographic strength of the SAID. Thus, an adversary could successfully discover via brute force the exact block by creating digests of all the elements of the power set which may be small enough to be computationally feasible instead of inverting the SAID itself. Sufficient entropy in the `u` field ensures that the cardinality of the power set allowed by the schema is at least as great as the entropy of the SAID digest algorithm itself.

A UUID, `u` field may optionally appear in any block (field map) at any level of an ACDC. Whenever a block in an ACDC includes a UUID, `u`, field then its associated SAID, `d`, field makes a blinded commitment to the contents of that block. The UUID, `u`, field is the blinding factor. This makes that block securely partially disclosable or even selectively disclosable notwithstanding disclosure of the associated schema of the block. The block contents can only be discovered given disclosure of the included UUID field. Likewise, when a UUID, `u`, field appears at the top level of an ACDC then that top-level SAID, `d`, field makes a blinded commitment to the contents of the whole ACDC itself. Thus, the whole ACDC, not merely some block within the ACDC, may be disclosed in a privacy-preserving (correlation minimizing) 

### Autonomic identifier (AID) fields

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/15
:::

Some fields, such as the `i`, Issuer identifier field, must each have an AID as its value. An AID is a fully qualified Self-certifying Identifier (SCID) that follows the KERI protocol [[ref: KERI]] [[ref: KERI]].  An AID is derived from one or more `(public, private)` key pairs using asymmetric or public-key cryptography to create verifiable digital signatures [[ref: DSig]]. Each AID has a set of one or more Controllers who each control a private key. By virtue of their private key(s), the Controllers may make statements on behalf of the associated AID backed by uniquely verifiable commitments via digital signatures on those statements. Any entity then may verify those signatures using the associated set of public keys. No shared or trusted relationship between the Controllers and Verifiers is required. The verifiable key state for AIDs is established with the KERI protocol [[ref: KERI]]. The use of AIDS enables ACDCs to be used in a portable but securely attributable, fully decentralized manner in an ecosystem that spans trust domains.

### Namespaced AIDs

Because KERI is agnostic about the namespace for any particular AID, different namespace standards may be used to express KERI AIDs or identifiers derived from AIDs as the value of these AID related fields in an ACDC. Some of the examples below use the W3C DID namespace specification with the `did:keri` method [[ref: DIDK_ID]. However, the examples would have the same validity from a KERI perspective if some other supported namespace was used or no namespace was used at all. The latter case consists of a bare KERI AID (identifier prefix) expressed in CESR format [[ref: CESR]].

### Attribute field

The top-level attribute section `a`, field value may have as its value a nested field map. Each level of nesting may be fully expanded or represented by its SAID. When present, the `a` field value provides the so-called payload data of the ACDC. The `a` field syntax is described in more detail below. An ACDC may either have an `a` field or an `A` field (see next section) but not both. 

### Selectively disclosable attribute aggregate field

The top-level selectively disclosable attribute aggregate section, `A`, field value is an aggregate of cryptographic commitments used to make a commitment to a set (bundle) of selectively disclosable attributes. The value of the attribute aggregate, `A`, field depends on the type of Selective disclosure mechanism employed. For example, the aggregate value could be the cryptographic digest of the concatenation of an ordered set of cryptographic digests, a Merkle tree root digest of an ordered set of cryptographic digests, or a cryptographic accumulator. The Selective disclosure mechanisms are described in detail in the Selective disclosure section. When present, the `A` field value provides the so-called payload data of the ACDC. The `A` field syntax is described in more detail below. An ACDC may either have an `a` field or an `A` field (see previous section) but not both.

### Edge field

The top-level edge section `e` field value makes a cryptographically verifiable commitment to other ACDCs via references to their SAIDs. The `e` field syntax is described in more detail below.

### Rule field

The top-level rule section `r`, field value provides both human and machine readable legal language that may be associated with the ACDC. This is a type of Ricardian contract. The `r` field syntax is described in more detail below.


### Field ordering

The ordering of the top-level fields when present in an ACDC must be as follows, `v`, `d`, `u`, `i`, `rd`, `s`, `a`, `A`, `e`, `r`.

## ACDC variants

There are several variants of ACDCs determined by the presence/absence of certain fields and/or the value of those fields when used in combination. The primary ACDC variants are public, private, metadata, and bespoke. A given variant may be targeted (untargeted). 

All the variants have two alternate forms, compact and non-compact. In the compact form of any variant, the values of the top-level fields for the schema, attribute, attribute aggregate, edge, and rule sections are the SAIDs (digests) of the corresponding expanded (non-compact) form of each section {{SAID}}. Additional variants arise from the presence or absence of different fields inside the attribute or attribute aggregate section. 

At the top level, the presence (absence), of the UUID, `u`, field produces two additional variant combinations. These are private (public), respectively. In addition, a present but empty UUID, `u`, field produces a private metadata variant. Furthermore, a given variant may be either targeted or untargeted based on the presence of the Issuee field in the attribute or attribute aggregate sections. Similarly, any variant with an attribute section may have nested sub-blocks within the attribute section that are either compact or non-compact. This enables nested partial disclosure. The type of disclosure a given variant supports may be dependent on how the different sections appear in the ACDC.

An overview of each variant is explained below.

### Most compact form SAID

As defined in the Schema Section below, ACDC variants are defined by composable JSON Schema. The primary operator for such composition is `oneOf`. The use of the `oneOf` operator for an ACDC schema enables the use of any combination of compacted/uncompacted top-level sections as well as nested blocks. When compact, any section or nested block may be represented merely by its SAID [[ref: JSch]] [[ref: JSchCp]].

However, for the sake of verifiability, each section or block that is compactable shall have only one SAID regardless of how many different variants its `oneOf` compositions allow. Therefore, there must be one and only one unambiguous way to compute the SAID of a compactifiable section or block with compactifiable nested blocks. This is called the "most compact form" SAID computation algorithm. The basis of the algorithm is that the SAID of a given block is verifiable against that block in expanded form but that SAID can be embedded in an enclosing block in compact form. The SAID of the enclosing block makes a verifiable commitment to the given block via the appearance of only the SAID of the given block. The SAID of the "most compact form" can be computed by a depth-first search.  First, compute the SAIDs of the expanded leaf nodes of the tree, then compact the leaves, then compute the SAIDs of their enclosing blocks, then compact those, and so on until the trunk has been reached.
To verify the SAID, just reverse the process. First, expand a given block, verify its SAID, expand its enclosed blocks, verify their SAIDs, and so on as deep as needed or until the leaves are reached. The main advantage of "most compact form" SAID computation is that it enables verification of portions of a set of nested compactifiable subblocks against their SAIDs without requiring that the whole tree of subblocks be exposed. This is essential to graduated disclosure.

The algorithm for computing the “most compact form" of a block for computing its SAID is as follows.

- A SAIDed block is any block that has a SAID field `d` when in block-level expanded form. Any SAIDed block is compactifiable into the compact form consisting of a string field whose value is the SAID of the block-level expanded form and whose label is the block label. This compact form shall appear as the first variant in the `oneOf` subschema list for its labeled field. In block-level expanded form, all fields with non-SAIDed subblock values are fully expanded, whereas all fields with SAIDed subblocks are represented in compact form. The latter requires first representing each SAIDed subblock in block-level expanded form, computing its SAID, and then using that SAID to represent it in compact form.

- A SAIDed block that does not have any nested SAIDed subblocks as fields is a leaf block. Its SAID shall be computed on the full expanded representation of the block. It may then be represented in the compact form but using the SAID computed on its fully expanded form. To clarify, because the leaf has no SAIDed subblocks, its block-level expanded form is fully expanded, including any fields with subblocks. This is a concern when it has subblocks whose schema has `oneOf` composition variants that omit any details. This is the case for a simple-compact edge or a simple-compact rule (see below under the Edge and Rule sections), which are each a nested (non-SAIDed) subblock with a non-SAID-based compact `oneOf` variant. These are special cases, and the most detailed variant of the subblock shall be the fully expanded form. 

- The computation of the SAID of any SAIDed block is as follows. 
    - Fully expand any field within the block whose value is a Non-SAIDed sub-block.
    - Compact any field within the block whose value is a leaf block with its SAID computed on its fully expanded form.
    - Compact any non-leaf SAIDed block with its SAID computed on its block-level expanded form. The SAID of any non-leaf SAIDed subblock is recursively computed. Once all SAIDed subblocks have been represented in compact form, the SAID of the SAIDed block is then computed on the resultant representation.
    
    
To elaborate, the algorithm recursively compacts a nested set of SAIDed subblocks by doing a depth-first search of all SAIDed subblock fields in a given block where each branch of the search terminates when it reaches a leaf subblock whereupon it computes the SAID of the leaf, compacts it and then continues the depth-first search until all the SAIDed subblock fields are compacted and then computes the SAID of that block and then ascends the tree, compacting subblocks and computing block SAIDs until it reaches the top-level block that is the ACDC itself. 

Thereby, there is one and only one "most compact form" SAID for any given ACDC as well as one and only one "most compact form" SAID for each of the ACDC top-level sections regardless of all the different variants allowed by the `oneOf` compositions of any SAIDed subblocks. This "most compact form," SAID, is what is used to reference an ACDC as the node value of an edge or to reference a Section.


### Compact ACDC

The top-level section field values of a Compact ACDC are the SAIDs of each uncompacted top-level section. The section field labels are `s`, `a`, (`A`), `e`, and `r`.


### Public ACDC

Given that there is no top-level UUID, `u`, field in an ACDC, then knowledge of both the schema of the ACDC and the top-level SAID, `d`, field may enable the discovery of the remaining contents of the ACDC via a rainbow table attack [[ref: RB]] [[ref: DRB]]. Therefore, although the top-level, `d`, field is a cryptographic digest, it may not securely blind the contents of the ACDC when knowledge of the schema is available.  The field values may be discoverable. Consequently, any cryptographic commitment to the top-level SAID, `d`, field may provide a fixed point of correlation potentially to the ACDC field values themselves in spite of non-disclosure of those field values. Thus, an ACDC without a top-level UUID, `u`, field must be considered a public (non-confidential) ACDC.

### Private ACDC

Given a top-level UUID, `u`, field, whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of an ACDC may provide a secure cryptographic digest that blinds the contents of the ACDC [[ref: Hash]]. An adversary when given both the schema of the ACDC and the top-level SAID, `d`, field, is not able to discover the remaining contents of the ACDC in a computationally feasible manner such as through a rainbow table attack [[ref: RB]] [[ref: DRB]]. Therefore, the top-level, UUID, `u`, field may be used to securely blind the contents of the ACDC notwithstanding knowledge of the schema and top-level, SAID, `d`, field.  Moreover, a cryptographic commitment to that that top-level SAID, `d`, field does not provide a fixed point of correlation to the other ACDC field values themselves unless and until there has been a disclosure of those field values. Thus, an ACDC with a sufficiently high entropy top-level UUID, `u`, field may be considered a private (confidential) ACDC. enables a verifiable commitment to the top-level SAID of a private ACDC to be made prior to the disclosure of the details of the ACDC itself without leaking those contents. This is called Partial disclosure. Furthermore, the inclusion of a UUID, `u`, field in a block also enables Selective disclosure mechanisms described later in the section on Selective disclosure.

### Metadata ACDC 

An empty, top-level UUID, `u`, field appearing in an ACDC indicates that the ACDC is a metadata ACDC. The purpose of a metadata ACDC is to provide a mechanism for a Discloser to make cryptographic commitments to the metadata of a yet to be disclosed private ACDC without providing any point of correlation to the actual top-level SAID, `d`, field of that yet to be disclosed ACDC. The top-level SAID, `d`, field, of the metadata ACDC, is cryptographically derived from an ACDC with an empty top-level UUID, `u`, field so its value will necessarily be different from that of an ACDC with a high entropy top-level UUID, `u`, field value. Nonetheless, the Discloser may make a non-repudiable cryptographic commitment to the metadata SAID in order to initiate a contractually protected exchange without leaking correlation to the actual ACDC to be disclosed [[ref: CLC]]. A Disclosee may verify the other metadata information in the metadata ACDC before agreeing to any restrictions imposed by the future disclosure. The metadata includes the Issuer, the schema, the provenancing edges, and the rules (terms-of-use). The top-level attribute section, `a`, field value, or the top-level attribute aggregate, `A` field value of a metadata ACDC may be empty so that its value is not correlatable across disclosures (presentations). Should the potential Disclosee refuse to agree to the rules, then the Discloser has not leaked the SAID of the actual ACDC or the SAID of the Attribute block that would have been disclosed.

Given the metadata ACDC, the potential Disclosee is able to verify the Issuer, the schema, the provenanced edges, and rules prior to agreeing to the rules.  Similarly, an Issuer may use a metadata ACDC to get agreement to a contractual waiver expressed in the rule section with a potential Issuee prior to issuance. Should the Issuee refuse to accept the terms of the waiver, then the Issuer has not leaked the SAID of the actual ACDC that would have been issued nor the SAID of its attributes block nor the attribute values themselves.

When a metadata ACDC is disclosed (presented), only the Discloser's signature(s) is attached, not the Issuer's signature(s). This precludes the Issuer's signature(s) from being used as a point of correlation until after the Disclosee has agreed to the terms in the rule section. When contractual protected disclosure is used, the Issuer's signature(s) are not disclosed to the Disclosee until after the Disclosee has agreed to the terms. The Disclosee is protected from a forged Discloser because, ultimately, verification of the disclosed ACDC will fail if the Discloser does not eventually provide verifiable Issuer's signatures. Nonetheless, should the potential Disclosee not agree to the terms of the disclosure expressed in the rule section, then the Issuer's signature(s) is not leaked.

### ACDC Examples

#### Compact public ACDC example

An example of a fully compact public ACDC is shown below. The ACDC is public because the `u` field is missing.

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "EFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPMmkPreYpZf",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "ERH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOA",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

The schema for the Compact public ACDC example above is provided below.

```json
{
  "$id": "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Compact Public ACDC",
  "description": "Example JSON Schema for a Compact private ACDC.",
  "credentialType": "CompactPublicACDCExample",
  "version": "1.0.0",
  "type": "object",
  "required":
  [
    "v",
    "d",
    "u",
    "i",
    "rd",
    "s",
    "a",
    "e",
    "r"
  ],
  "properties":
  {
    "v":
    {
      "description": "ACDC version string",
      "type": "string"
    },
    "d":
    {
     "description": "ACDC SAID",
      "type": "string"
    },
    "i":
    {
      "description": "Issuer AID",
      "type": "string"
    },
    "rd":
    {
      "description": "Registry SAID",
      "type": "string"
    },
    "s": 
    {
      "description": "schema SAID",
      "type": "string"
    },
    "a": 
    {
      "description": "attribute SAID",
      "type": "string"
    },
    "e": 
    {
      "description": "edge SAID",
      "type": "string"
    },
    "r": 
    {
      "description": "rule SAID",
      "type": "string"
    }
  },
  "additionalProperties": false
}
```


#### Compact private ACDC example.

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/22
:::

An example of a fully compact private ACDC is shown below. The ACDC is private because the `u` field is non-empty.

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "u":  "0ANghkDaG7OY1wjaDAE0qHcg",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "ERH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOA",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}

```

The schema for the Compact private ACDC example above is provided below.

```json
{
  "$id": "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Compact Private ACDC",
  "description": "Example JSON Schema for a Compact private ACDC.",
  "credentialType": "CompactPrivateACDCExample",
  "version": "1.0.0",
  "type": "object",
  "required":
  [
    "v",
    "d",
    "u",
    "i",
    "rd",
    "s",
    "a",
    "e",
    "r"
  ],
  "properties":
  {
    "v":
    {
      "description": "ACDC version string",
      "type": "string"
    },
    "d":
    {
     "description": "ACDC SAID",
      "type": "string"
    },
    "u":
    {
     "description": "ACDC UUID",
      "type": "string"
    },
    "i":
    {
      "description": "Issuer AID",
      "type": "string"
    },
    "rd":
    {
      "description": "Registry SAID",
      "type": "string"
    },
    "s": 
    {
      "description": "schema SAID",
      "type": "string"
    },
    "a": 
    {
      "description": "attribute SAID",
      "type": "string"
    },
    "e": 
    {
      "description": "edge SAID",
      "type": "string"
    },
    "r": 
    {
      "description": "rule SAID",
      "type": "string"
    }
  },
  "additionalProperties": false
}
```

## Top-level ACDC sections

### Schema section

#### Type-is-schema

Notable is the fact that no top-level type fields exist in an ACDC. This is because the schema, `s`, field itself is the type field for the ACDC and its parts. ACDCs follow the design principle of separation of concerns between a data container's actual payload information and the type information of that container's payload. In this sense, type information is metadata, not data. The schema dialect used by ACDCs is JSON Schema 2020-12 [[ref: JSch]] [[ref: JSch_202012]]. JSON Schema supports composable schema (sub-schema), conditional schema (sub-schema), and regular expressions in the schema. Composability enables a Validator to ask and answer complex questions about the type of even optional payload elements while maintaining isolation between payload information and type (structure) information about the payload [[ref: JSchCp]] [[ref: JSchRE]] [[ref: JSchId]] [[ref: JSchCx]]. A static but composed schema allows a verifiably immutable set of variants. Although the set is immutable, the variants enable graduated but secure disclosure. ACDC's use of JSON Schema must be in accordance with the ACDC defined profile as defined herein. The exceptions are defined below.

#### Schema ID field label

The usual field label for SAID fields in ACDCs is `d`. In the case of the schema section, however, the field label for the SAID of the schema section is `$id`. This repurposes the schema id field label, `$id` as defined by JSON Schema [[ref: JSchId]] [[ref: JSchCx]].  The top-level id, `$id`, field value in a JSON Schema provides a unique identifier of the schema instance. In a non-ACDC schema, the value of the id, `$id`, field is expressed as a URI. This is called the Base URI of the schema. In an ACDC schema, however, the top-level id, `$id`, field value is repurposed. This field value must include the SAID of the schema. This ensures that the ACDC schema is static and verifiable to their SAIDS. A verifiably static schema satisfies one of the essential security properties of ACDCs as discussed below. There are several ACDC supported formats for the value of the top-level id, `$id`, field but all of the formats must include the SAID of the schema (see below). Correspondingly, the value of the top-level schema, `s`, field must be the SAID included in the schema's top-level `$id` field. The detailed schema is either attached or cached and maybe discovered via its SAIDified, id, `$id`, field value.

The digest algorithm employed for generating schema SAIDS shall have an approximate cryptographic strength of 128 bits. The SAID MUST be generated in compliance with the ToIP SAID internet draft specification and MUST be encoded using CESR. The CESR encoding indicates the type of cryptographic digest used to generate the SAID. 


When an id, '$id', field appears in a sub-schema, it indicates a bundled sub-schema called a schema resource [[ref: JSchId]] [[ref: JSchCx]]. The value of the id, '$id', field in any ACDC bundled sub-schema resource must include the SAID of that sub-schema using one of the formats described below. The sub-schema so bundled must be verifiable against its referenced and embedded SAID value. This ensures secure bundling.

#### Static (immutable) schema

For security reasons, the full schema of an ACDC must be completely self-contained and statically fixed (immutable) for that ACDC meaning that no dynamic schema references or dynamic schema generation mechanisms are allowed.

Should an adversary successfully attack the source that provides the dynamic schema resource and change the result provided by that reference, then the schema validation on any ACDC that uses that dynamic schema reference may fail. Such an attack effectively revokes all the ACDCs that use that dynamic schema reference, which is called a schema revocation attack.

More insidiously, an attacker could shift the semantics of the dynamic schema in such a way that although the ACDC still passes its schema validation, the behavior of the downstream processing of that ACDC is changed by the semantic shift. This type of attack is called a semantic malleability attack which may be considered a new type of transaction malleability attack [[ref: TMal]].

To prevent both forms of attack, all schema must be static, i.e., schema must be SADs and therefore verifiable against their SAIDs.

To elaborate, the serialization of a static schema may be self-contained. A compact commitment to the detailed static schema may be provided by its SAID. In other words, the SAID of a static schema is a verifiable cryptographic identifier for its SAD. Therefore, all ACDC compliant schema must be SADs. In other words, the schema must therefore be SAIDified. The associated detailed static schema (uncompacted SAD) is bound cryptographically and verifiable to its SAID.

The JSON Schema specification allows complex schema references that may include non-local URI references [[ref: JSchId]] [[ref: JSchCx]] [[ref: RFC3986]] [[ref: RFC8820]]. These references may use the `$id` or `$ref` keywords. A relative URI reference provided by a `$ref` keyword is resolved against the Base URI provided by the top-level `$id` field. When this top-level Base URI is non-local, then all relative `$ref` references are therefore also non-local. A non-local URI reference provided by a `$ref` keyword may be resolved without reference to the Base URI.

In general, schema indicated by non-local URI references (`$id` or `$ref`) must not be used because they are not cryptographically end-verifiable. The value of the underlying schema resource so referenced may change (mutate). To restate, a non-local URI schema resource is not end-verifiable to its URI reference because there is no cryptographic binding between URI and resource [[ref: RFC3986]] [[ref: RFC8820]].

This does not preclude the use of remotely cached SAIDified schema resources because those resources are end-verifiable to their embedded SAID references. Said another way, a SAIDified schema resource is itself a SAD  referenced by its SAID. A URI that includes a SAID may be used to securely reference a remote or distributed SAIDified schema resource because that resource is fixed (immutable, nonmalleable) and verifiable to both the SAID in the reference and the embedded SAID in the resource so referenced. To elaborate, a non-local URI reference that includes an embedded cryptographic commitment such as a SAID is verifiable to the underlying resource when that resource is a SAD. This applies to JSON Schema as a whole as well as bundled sub-schema resources.

There ACDC supported formats for the value of the top-level id, `$id`, field are as follows:

Bare SAIDs may be used to refer to a SAIDified schema as long as the JSON schema validator supports bare SAID references. By default, many if not all JSON schema validators support bare strings (non-URIs) for the Base URI provided by the top-level `$id` field value.

-	The `sad:` URI scheme may be used to directly indicate a URI resource that safely returns a verifiable SAD. For example, `sad:SAID` where SAID* is replaced with the actual SAID of a SAD that provides a verifiable non-local reference to JSON Schema as indicated by the media-type of `schema+json`.

-	The KERI OOBI specification provides a URL syntax that references a SAD resource by its SAID at the service endpoint indicated by that URL [[ref: OOBI]]. Such remote OOBI URLs are also safe because the provided SAD resource is verifiable against the SAID in the OOBI URL. Therefore, OOBI URLs are also acceptable non-local URI references for JSON Schema [[ref: OOBI]] [[ref: RFC3986]] [[ref: RFC8820]].

-	The `did:` URI scheme may be used safely to prefix non-local URI references that act to namespace SAIDs expressed as DID URIs or DID URLs.  DID resolvers resolve DID URLs for a given DID method such as `did:keri` [[ref: DIDK_ID]] and may return DID docs or DID doc metadata with SAIDified schema or service endpoints that return SAIDified schema or OOBIs that return SAIDified schema [[ref: RFC3986]] [[ref: RFC8820]] [[ref: OOBI]]. A verifiable non-local reference in the form of DID URL that includes the schema SAID is resolved safely when it dereferences to the SAD of that SAID. For example, the resolution result returns an ACDC JSON Schema whose id, `$id`, field includes the SAID and returns a resource with JSON Schema mime-type of `schema+json`.


To clarify, ACDCs must not use complex JSON Schema references which allow dynamically generated schema resources to be obtained from online JSON Schema Libraries [[ref: JSchId]] [[ref: JSchCx]]. The latter approach may be difficult or impossible to secure because a cryptographic commitment to the base schema that includes complex schema (non-relative URI-based) references only commits to the non-relative URI reference and not to the actual schema resource which may change (is dynamic, mutable, malleable). To restate, this approach is insecure because a cryptographic commitment to a complex (non-relative URI-based) reference is not equivalent to a commitment to the detailed associated schema resource so referenced if it may change.

ACDCs must use static JSON Schema (i.e., SAIDifiable schema). These may include internal relative references to other parts of a fully self-contained static (SAIDified) schema or references to static (SAIDified) external schema parts. As indicated above, these references may be bare SAIDs, DID URIs or URLs (`did:` scheme), SAD URIs (`sad:` scheme), or OOBI URLs [[ref: OOBI]]. Recall that a commitment to a SAID with sufficient collision resistance makes an equivalent secure commitment to its encapsulating block SAD. Thus, static schema may be either fully self-contained or distributed in parts but the value of any reference to a part must be verifiably static (immutable, nonmalleable) by virtue of either being relative to the self-contained whole or being referenced by its SAID. The static schema in whole or in parts may be attached to the ACDC itself or provided via a highly available cache or data store. To restate, this approach is securely end-verifiable (zero-trust) because a cryptographic commitment to the SAID of a SAIDified schema is equivalent to a commitment to the detailed associated schema itself (SAD).

#### Schema dialect

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/18
:::

The Schema dialect for ACDC 1.0 is JSON Schema 2020-12 and is indicated by the identifier `"https://json-schema.org/draft/2020-12/schema"`  [[ref: JSch]] [[ref: JSch_202012]]. This is indicated in a JSON Schema via the value of the top-level `$schema` field. Although the value of `$schema` is expressed as a URI, de-referencing does not provide dynamically downloadable schema dialect validation code. This would be an attack vector. The Validator must control the tooling code dialect used for schema validation and hence the tooling dialect version actually used. A mismatch between the supported tooling code dialect version and the `$schema` string value should cause the validation to fail. The string is simply an identifier that communicates the intended dialect to be processed by the schema validation tool. When provided, the top-level `$schema` field value for ACDC version 1.0 must be "https://json-schema.org/draft/2020-12/schema".

#### Schema versioning

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/20
:::

Each schema shall have at the top level version field with field label `version`. The value of the `version` field shall be a semantic version string in the dotted decimal notation of the form "major.minor.path" . For example, "1.2.3" has a major version number of 1, a minor version number of 2, and a patch version of 3. This value is informative. The `version` field value is not used in the JSON Schema validation against the ACDC. Therefore, a given ACDC may properly pass JSON Schema validation process regardless of the value of its schema `version` field.  

{{Semantic Versioning Specification 2.0 https://semver.org}}


Recall that the value of the Schema ID, `$id` field in an ACDC schema is a SAID which provides an encoded agile cryptographic digest of the contents of the schema. Any change to the schema, including a change to its `version` field, results in a new SAID. Any copy of a schema that verifies against the same SAID given by the Schema ID, `$id` field value can be assumed to be identical to any other copy that verifies to the same SAID by virtue of the strong collision resistance of the digest employed.

This gives rise to two meanings of the word "version" when applied to an ACDC's schema. One is the version given by the value of its `$id` field, and the other is the version given by its `version` field. The version provided by the `$id` field is cryptographically verifiable. Whereas the version provided by the `version` field is not. Thus, the latter is an informative indication of the version, and the former is a normative determiner of the version. In this sense, the schema ID, `$id` field value as a SAID provides a cryptographically verifiable version indicator independent of the version field value. To avoid confusion, any change to the schema that changes the value of the `$id` shall also be reflected in a correspondingly unique value of its `version` field. Business logic may depend on consistency between the `version` field value with respect to the `$id` field value. Notwithstanding the actual value of the `version` field, the `$id` field value is the normative determiner of the schema's true, verifiable version.

The JSON schema for an ACDC may use composition operators (see below). This allows extensibility in schema such that, in some cases, ACDCs with newer schema versions may be backward (im)compatible with older schema versions. A new schema version, as given by the `$id` field value, is considered backward incompatible with respect to a previous version of a schema when any instance of an ACDC that validates (in the JSON Schema sense of validation) against the previous version of the schema may not be guaranteed to validate against the new version. Because any change to the `version` field value results in a different `$id` field value, the backward compatibility rule also applies changes in the `version` field value. To comply with the semantic versioning rules, a backward incompatible schema shall have a higher major version number in its `version` field value than any backward incompatible version.


#### Schema availability

The composed detailed (uncompacted) (bundled) static schema for an ACDC may be cached or attached. But cached, and/or attached static schema is not to be confused with dynamic schema. Nonetheless, while securely verifiable, a remotely cached, SAIDified, schema resource may be unavailable. Availability is a separate concern. Unavailable does not mean insecure or unverifiable. ACDCs must be verifiable when available.  Availability is typically solvable through redundancy. Although a given ACDC application domain or ecosystem governance framework may impose schema availability constraints, this ACDC specification itself does not impose any specific availability requirements on Issuers other than schema caches should be sufficiently available for the intended application of their associated ACDCs. It is up to the Issuer of an ACDC to satisfy any availability constraints on its schema that may be imposed by the application domain or ecosystem.

#### Composable JSON Schema

A composable JSON Schema enables the use of any combination of compacted/uncompacted attribute, edge, and rule sections in a provided ACDC. When compact, any one of these sections may be represented merely by its SAID [[ref: JSch]] [[ref: JSchCp]]. When used for the top-level attribute, `a`, edge, `e`, or rule, `r`, section field values, the `oneOf` sub-schema composition operator provides both compact and uncompacted variants. The provided ACDC must validate against an allowed combination of the composed variants. The Validator determines what decomposed variants the provided ACDC must also validate against. Decomposed variants may be dependent on the type of Graduated disclosure. Essentially, a composable schema is a verifiable bundle of metadata (composed) about content that can then be verifiably unbundled (decomposed) later. The Issuer makes a single verifiable commitment to the bundle (composed schema), and a recipient may then safely unbundle (decompose) the schema to validate any of the Graduated disclosure variants allowed by the composition.

Unlike the other compactifiable sections, it is impossible to define recursively the exact detailed schema as a variant of a `oneOf` composition operator contained in itself.  Nonetheless, the provided schema, whether self-contained, attached, or cached must validate as a SAD against its provided SAID. It also must validate against one of its specified `oneOf` variants. Typically, it's SAID or a generic object.

The compliance of the provided non-schema attribute, `a`, edge, `e`, and rule, `r`, sections must be enforced by validating against the composed schema. In contrast, the compliance of the provided composed schema for an expected ACDC type must be enforced by the Validator. This is because it is not possible to enforce strict compliance of the schema by validating it against itself.

ACDC-specific schema compliance requirements usually are specified in the ecosystem governance framework (EGF) for a given ACDC type.  Because the SAID of a schema is a unique content-addressable identifier of the schema itself, compliance can be enforced by comparison to the allowed schema SAID in a well-known publication or registry of ACDC types for a EGF. The EGF may be specified solely by the Issuer for the ACDCs it generates or be specified by some mutually agreed upon ecosystem governance mechanism. Typically, the business logic for making a decision about a presentation of an ACDC starts by specifying the SAID of the composed schema for the ACDC type that the business logic is expecting from the presentation. The verified SAID of the actually presented schema is then compared against the expected SAID. If they match, then the actually presented ACDC may be validated against any desired decomposition of the expected (composed) schema.

To elaborate, a Validator can confirm compliance of any non-schema section of the ACDC against its schema both before and after uncompacted disclosure of that section by using a composed base schema with `oneOf` pre-disclosure and a decomposed schema post-disclosure with the compact `oneOf` option removed. This capability provides a mechanism for secure schema validation of both Compact and uncompacted variants that require the Issuer to only commit to the composed schema and not to all the different schema variants for each combination of a given compact/uncompacted section in an ACDC.

One of the most important features of ACDCs is support for Chain-link confidentiality [[ref: CLC]]. This provides a powerful mechanism for protecting against unpermissioned exploitation of the data disclosed via an ACDC. Essentially, an exchange of information compatible with Chain-link confidentiality starts with an offer by the Discloser to disclose confidential information to a potential Disclosee. This offer includes sufficient metadata about the information to be disclosed such that the Disclosee can agree to those terms. Specifically, the metadata includes both the schema of the information to be disclosed and the terms of use of that data once disclosed. Once the Disclosee has accepted the terms, then Full disclosure is made. A full disclosure that happens after contractual acceptance of the terms of use is called permissioned disclosure. The pre-acceptance disclosure of metadata is a form of Partial disclosure.

As is the case for Compact (uncompacted) ACDC disclosure, composable JSON schema enables the use of the same base schema for both the validation of the Partial disclosure of the offer metadata prior to contract acceptance and validation of full or detailed disclosure after contract acceptance [[ref: JSch]][[ref: JSchCp]]. A cryptographic commitment to the base schema securely specifies the allowable semantics for both Partial and Full disclosure. Decomposition of the base schema enables a Validator to impose more specific semantics at later stages of the exchange process. Specifically, the `oneOf` sub-schema composition operator validates against either the compact SAID of a block or the full block. Decomposing the schema to remove the optional Compact variant enables a Validator to ensure complaint Full disclosure. To clarify, a Validator can confirm schema compliance both before and after detailed disclosure by using a composed base schema pre-disclosure and a decomposed schema post-disclosure with the undisclosed options removed. These features provide a mechanism for secure schema-validated contractually-bound Partial (and/or Selective) disclosure of confidential data via ACDCs.

### Attribute section

#### Reserved field labels

The following field labels are reserved at all nested field map levels in the Attribute section of an ACDC.
 
| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Identifier (AID)| Context dependent AID as determined by its enclosing map such as Issuee identifier. |

#### Compact attribute section schema

When the value of the  Attribute section has been compacted into its SAID, its schema is as follows: 

```json
{
  "a":
  {
    "description": "attribute section SAID",
    "type": "string"
  }
}
```

[//]: # (Create issue to resolve this)

#### Attribute section variants

Two variants, namely, targeted (untargeted), are defined respectively by the presence (absence) of an Issuee, `i` field at the top-level of the uncompacted Attribute section block.

Two other variants, namely private (public), are defined respectively by the presence (absence) of a UUID, `u`, field at the top-level of the uncompacted Attribute section block.

These four variants may appear in combination.

##### Targeted attribute section 

Consider the case where the Issuee, `i`, field is present at the top level of the Attribute section, as shown below:

```json
{
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA",
    "temp": 45,
    "lat": "N40.3433",
    "lon": "W111.7208"
  }
}
```
When present at the top level of the Attribute section, the Issuee, `i`, field value is the ACDC's Issuee AID. This Issuee AID is a provably controllable identifier that is the Target. This makes the ACDC a Targeted ACDC. Targeted ACDCs may be used for many different purposes, such as authorization or delegation directed at the Target. In other words, a targeted ACDC provides a container for authentic data that may also be used as some form of authorization, such as a credential that is verifiably bound to the Issuee as targeted by the Issuer. Furthermore, by virtue of the targeted Issuee's provable control over its AID, the Targeted ACDC may be verifiably presented (disclosed) by the Issuee AID Controller.

To elaborate, the definition of the term credential is "evidence of authority, status, rights, entitlement to privileges, or the like". The presence of an attribute section top-level Issuee, `i`, field enables the ACDC to be used as a verifiable credential given by the Issuer to the Issuee.

One reason the Issuee, `i`, field is nested into the Attribute section, `a`, block is to enable the Issuee AID to be partially or selectively disclosable. Because the actual semantics of Issuee may depend on the use case, the semantically precise albeit less common terms of Issuer and Issuee are used in this specification. In some use cases, for example, an Issuee may be called the Holder; in others, the Subject of the ACDC. But no matter the use case, the `i` field designates the Issuee AID, i.e. Target. The ACDC is "issued by" an Issuer and is "issued to" an Issuee. This precise terminology does not bias or color the role (function) that an Issuee plays in using an ACDC. What the presence of Issuee AID does provide is a mechanism for control of the subsequent use of the ACDC once it has been issued. To elaborate, because the Issuee, `i`, field value is an AID, by definition, there is a provable Controller of that AID. Therefore, the Issuee Controller may make non-repudiable commitments via digital signatures on behalf of its AID.  Therefore, subsequent use of the ACDC by the Issuee may be securely attributed to the Issuee.

Importantly, the presence of an Issuee, `i`, field enables the associated Issuee to make authoritative verifiable presentations or disclosures of the ACDC. A designated Issuee also better enables the initiation of presentation exchanges of the ACDC between that Issuee as Discloser and a Disclosee (Verifier).

In addition, because the Issuee is a specified counterparty, the Issuer may engage in a contract with the Issuee that the Issuee agrees to by virtue of its non-repudiable signature on an offer of the ACDC prior to its issuance. This agreement may be a pre-condition to the issuance and thereby impose liability waivers or other terms of use on that Issuee. 

Likewise, the presence of an Issuee, `i`, field enables the Issuer to use the ACDC as a contractual vehicle for conveying authorization to the Issuee.  This enables verifiable delegation chains of authority because the Issuee in one ACDC may become the Issuer of another ACDC. Thereby, an Issuer may delegate authority to an Issuee who may then become a verifiably authorized Issuer that then delegates that authority (or attenuation of that authority) to some other verifiably authorized Issuee and so forth.

Contractual issuance and presentation exchanges are described in detail later in the IPEX protocol section {{reference to IPEX section}}.

##### Untargeted attribute section

Consider the case where the Issuee, `i`, field is absent at the top level of the Attribute section, as shown below:

```json
{
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "temp": 45,
    "lat": "N40.3433",
    "lon": "W111.7208"
  }
}
```
This ACDC has an Issuer but no Issuee. There is no provably controllable AID as a Target of the issuance, i.e., Untargeted. The data in the Attribute section may be considered an undirected verifiable attestation or observation by the Issuer.  One could say that the attestation is addressed "to whom it may concern." An untargeted ACDC enables verifiable authorship by the Issuer of the data in the Attributes section, but there is no specified counterparty and no verifiable mechanism for delegation of authority.  Consequently, the Rule section may provide only contractual obligations of implied counterparties.

This form of an ACDC provides a container for authentic data only (not authentic data as authorization). But authentic data is still a very important use case. To clarify, an Untargeted ACDC enables verifiable authorship of data. An observer, such as a sensor that controls an AID, may make verifiable, nonrepudiable measurements and publish them as ACDCs. These may be chained together to provide provenance for or a chain-of-custody of any data.  Furthermore, A hybrid chain of one or more targeted ACDCs ending in a chain of one or more untargeted ACDCs enables delegated authorized attestations at the tail of that chain. These provenanceable chains of ACDCs could be used to provide a verifiable data supply chain for any compliance-regulated application. This provides a way to protect participants in a supply chain from imposters. Such data supply chains are also useful as a verifiable digital twin of a physical supply chain [[ref: Twin]].


#### Targeted private-attribute section example

Consider the following form of an uncompacted private-attribute block,

```json
{
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "u": "0AwjaDAE0qHcgNghkDaG7OY1",
    "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA",
    "score": 96,
    "name": "Jane Doe"
  }
}
```


with subschema below,


```json
{
  "a":
  {
    "description": "attribute section",
    "oneOf":
    [
      {
        "description": "attribute SAID",
        "type": "string"
      },
      {
        "description": "uncompacted attribute section",
        "type": "object",
        "required":
        [
          "d",
          "u",
          "i",
          "score",
          "name"
        ],
        "properties":
        {
          "d":
          {
            "description": "attribute SAID",
            "type": "string"
          },
          "u":
          {
            "description": "attribute UUID",
            "type": "string"
          },
          "i":
          {
            "description": "Issuee AID",
            "type": "string"
          },
          "score":
          {
            "description": "test score",
            "type": "integer"
          },
          "name":
          {
            "description": "test taker full name",
            "type": "string"
          }
        },
        "additionalProperties": false
      }
    ]
  }
}
```


As described above in the Schema section of this specification, the `oneOf` sub-schema composition operator validates against either the compact SAID of a block or the full block. A Validator can use a composed schema that has been committed to by the Issuer to securely confirm schema compliance both before and after detailed disclosure by using the fully composed base schema pre-disclosure and a specific decomposed variant post-disclosure. Decomposing the schema to remove the optional compact variant (i.e., removing the `oneOf` compact option) enables a Validator to ensure compliant Full disclosure. To clarify, using the JSON Schema `oneOf` composition operator enables the composed subschema to validate against both the compact and un-compacted value of the private-attribute section, `a`, field.

As discussed above, the presence of the `i` field at the top level of the attribute section block makes this a targeted attribute section. The AID given by the `i` field value is the target entity called the Issuee. The semantics of the Issuee maybe defined by the ACDC EGF (Ecosystem Governance Framework).

Given the presence of a top-level UUID, `u`, field of the attribute block whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of the attribute block provides a secure cryptographic digest of the contents of the attribute block [[ref: Hash]]. An adversary when given both the schema of the attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the attribute block in a computationally feasible manner such as a rainbow table attack [[ref: RB]] ] [[ref: DRB]].  Therefore, the attribute block's UUID, `u`, field in a compact ACDC enables its attribute block's SAID, `d`, field to securely blind the contents of the attribute block notwithstanding knowledge of the attribute block's schema and SAID, `d` field.  Moreover, a cryptographic commitment to that attribute block's, SAID, `d`, field does not provide a fixed point of correlation to the attribute field values themselves unless and until there has been a disclosure of those field values.

To elaborate, when an ACDC includes a sufficiently high entropy UUID, `u`, field at the top level of its attributes block then the ACDC may be considered a private-attributes ACDC when expressed in compact form, that is, the attribute block is represented by its SAID, `d`, field and the value of its top-level Attribute section, `a`, field is the value of the nested SAID, `d`, field from the uncompacted version of the attribute block. A verifiable commitment may be made to the compact form of the ACDC without leaking details of the attributes. Later disclosure of the uncompacted attribute block may be verified against its SAID, `d`, field that was provided in the compact form as the value of the top-level Attribute section, `a`, field.

Because the Issuee AID is nested in the attribute block as that block's top-level, Issuee, `i`, field, a presentation exchange (disclosure) could be initiated on behalf of a different AID that has not yet been correlated to the Issuee AID and then only correlated to the Issuee AID after the Disclosee has agreed to the Chain-link confidentiality provisions in the rules section of the private-attributes ACDC [[ref: CLC]].

#### Targeted public-attribute section example

Suppose that the un-compacted value of the attribute section as denoted by the Attribute section, `a`, field is as follows,

```json
{
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA",
    "score": 96,
    "name": "Jane Doe"
  }
}
```

with subschema below,

```json
{
  "a":
  {
    "description": "attribute section",
    "oneOf":
    [
      {
        "description": "attribute section SAID",
        "type": "string"
      },
      {
        "description": "uncompacted attribute section",
        "type": "object",
        "required":
        [
          "d",
          "i",
          "score",
          "name"
        ],
        "properties":
        {
          "d":
          {
            "description": "attribute section SAID",
            "type": "string"
          },
           "u":
          {
            "description": "attribute section UUID",
            "type": "string"
          },
          "i":
          {
            "description": "Issuee AID",
            "type": "string"
          },
          "score":
          {
            "description": "grade point average",
            "type": "integer"
          },
          "name":
          {
            "description": "test taker full name",
            "type": "string"
          }
        },
        "additionalProperties": false
      }
    ]
  }
}
```

As described above in the Schema section of this specification, the `oneOf` sub-schema composition operator validates against either the compact SAID of a block or the full block. A Validator can use a composed schema that has been committed to by the Issuer to securely confirm schema compliance both before and after detailed disclosure by using the fully composed base schema pre-disclosure and a specific decomposed variant post-disclosure. Decomposing the schema to remove the optional compact variant (i.e., removing the `oneOf` compact option) enables a Validator to ensure compliant Full disclosure. To clarify, using the JSON Schema `oneOf` composition operator enables the composed subschema to validate against both the compact and un-compacted value of the public-attribute section, `a`, field.

The SAID, `d`, field at the top level of the uncompacted attribute block is the same SAID used as the compacted value of the Attribute section, `a`, field.

As discussed above, the presence of the `i` field at the top level of the attribute section block makes this a targeted attribute section. The AID given by the `i` field value is the Target or Issuee. The semantics of the issuance may be defined by the ACDC's EGF (Ecosystem Governance Framework).

Given the absence of a `u` field at the top level of the attributes block, however, knowledge of both SAID, `d`, field at the top level of an attributes block and the schema of the attributes block may enable the discovery of the remaining contents of the attributes block via a rainbow table attack [[ref: RB]] ] [[ref: DRB]]. Therefore, the SAID, `d`, field of the attributes block, although a cryptographic digest, does not securely blind the contents of the attributes block given knowledge of the schema. It only provides compactness, not privacy. Moreover, any cryptographic commitment to that SAID, `d`, field potentially provides a fixed correlation point to the attribute block field values despite the non-disclosure of those field values via a Compact Attribute section. Thus, an ACDC without a UUID, `u` field in its attributes block must be considered a Public-Attribute ACDC even when expressed in compact form.

#### Nested partially disclosable attribute section example

Suppose that the un-compacted value of the Attribute section of an ACDC is as follows:

Attribute section:

```json
{
  "a":
  {
    "d": "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9",
    "u": "0ADAE0qHcgNghkDaG7OY1wja",
    "i": "EFv7vklXKhzBrAqjsKAn2EDIPmkPreYApZfFk66jpf3u",
    "name": "Jane Doe"
    "gpa": 3.50,
    "grades":
    {
      "d": "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9",
      "u": "0AHcgNghkDaG7OY1wjaDAE0q",
      "history": 3.00,
      "english": 4.00,
      "math": 3.0
    }
  }
}
```

Attribute section subschema:

```json
{
  "a":
  {
    "description": "attribute section",
    "oneOf":
    [
      {
        "description": "attribute SAID",
        "type": "string"
      },
      {
        "description": "attribute section detail",
        "type": "object",
        "required":
        [
          "d",
          "u",
          "i",
          "name"
          "gpa",
          "grades"
        ],
        "properties":
        {
          "d":
          {
            "description": "attribute SAID",
            "type": "string"
          },
          "i":
          {
            "description": "Issuee AID",
            "type": "string"
          },
          "name":
          {
            "description": "student full name",
            "type": "string"
          },
          "gpa":
          {
            "description": "grade point average",
            "type": "number"
          },
          "grades":
          {
            "description": "grades by subject block",
            "oneOf":
            [
              {
                "description": "block SAID",
                "type": "string"
              },
              {
                "description": "block detail",
                "type": "object",
                "required":
                [
                  "d",
                  "u",
                  "history"
                  "english",
                  "math"
                ],
                "properties":
                {
                  "d":
                  {
                    "description": "block SAID",
                    "type": "string"
                  },
                  "U":
                  {
                    "description": "block UUID",
                    "type": "string"
                  },
                  "history":
                  {
                    "description": "history grade",
                    "type": "number"
                  },
                  "english":
                  {
                    "description": "english grade",
                    "type": "number"
                  },
                  "math":
                  {
                    "description": "math grade",
                    "type": "number"
                  }
                },
                "additionalProperties": false
              }
            ]
          },
          "additionalProperties": false
        }
      }
    ]
  }
}
```

The attribute section subschema includes a `oneOf` composition operator at the grades subblock. The `grades` subblock has both a block level SAID, `d` and UUID, `u` field. This, means that the `grades` subblock detail can be hidden so that only the top-level fields in the Attribute section are disclosed. The following shows a compatible partially disclosed variant of the attribute section.

Partially disclosed attribute section:

```json
{
  "a":
  {
    "d": "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9",
    "u": "0ADAE0qHcgNghkDaG7OY1wja",
    "i": "EFv7vklXKhzBrAqjsKAn2EDIPmkPreYApZfFk66jpf3u",
    "name": "Jane Doe"
    "gpa": 3.50,
    "grades": "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9"
  }
}
```

Notice that the compact form of the `grades` subblock has as the field value of the `grades` field the value of the SAID, `d` field in the expanded version (see above). This means that when the subblock detail is provided, a validator can verify it against the SAID provided in the compact (partially disclosed) form.

### Edge section  

The Edge Section, `e` field appears as a top-level block within the ACDC.  The Edge Section has several reserved fields that may appear as top-level fields within its block. 

#### Block types

There are two types of field maps or blocks that may appear as values of fields within the Edge Section, `e` field either at the top level of the Edge block itself or nested. These are Edges or Edge-groups. Edges may only appear as locally unique labeled (using non-reserved labels)  blocks nested within an Edge Group. There are two exceptions for Edges, compact and simple compact form. In these two forms the Edge field value is not a block but a string. These exceptions are defined below.

The Edge Section is the top-level Edge-group. 

Nested Edge-groups may only appear as locally unique labeled blocks nested within another Edge-group. The block type, Edge or Edge-group, is indicated by its corresponding labeled sub-schema, with the exception of the top-level Edge-group, which is the Edge Section and is indicated by the Edge Section sub-schema. An Edge is indicated by the required presence of a node, `n` field in the non-compact variant of its sub-schema. An Edge-group shall not have a node, `n` field.

#### ACDCs as secure graph fragments of a globally distributed property graph (PG)

A set of ACDCs as nodes connected by edges forms a labeled property graph (LPG) or property graph (PG) for short [[ref: PGM]] [[ref: Dots]] [[ref: KG]]. Property graphs have properties not only in the nodes but also in the edges. The properties of each node (ACDC) are provided essentially by its Attribute Section. The properties of each edge are provided by the combination of Edge blocks and Edge-group blocks. In this regard, the set of nested Edge-groups within a given top-level Edge Section, i.e., the `e` field block of a given ACDC, constitute a sub-graph of a super-graph of ACDCs where the nodes of the super-graph are ACDCs. The nodes of the sub-graph are the Edge-groups and Edges, not whole ACDCs. One of the attractive features of property graphs (PGs) is their support for different edge and node types, which enables nested sub-graphs that support the rich expression of complex logical or aggregative operations on groups of Edges and/or Edge-groups (as subnodes) within the top-level Edge Section, `e`, field of an ACDC (as supernode).

To clarify, the Edge Section of an ACDC forms a sub-graph where each Edge block is a leaf of a branch in that sub-graph that terminates at the value of its node, `n`, field. Its node, `n` field, points to some other ACDC that is itself a sub-graph. The head of each sub-graph is the top level Edge-group, i.e. the Edge Section. Thus, an Edge block is a leaf with respect to the sub-graph formed by any nested Edge-group blocks in which the Edge appears.  

Abstractly, an ACDC with one or more edges may be viewed as a fragment of a larger distributed property graph where each ACDC Edge Section is a sub-graph. Each node in this larger graph is universally uniquely identified by the SAID of its ACDC. Recall that a SAID is a cryptographic digest. The local labels on each Edge block or Edge-group block are not universally uniquely resolvable, so they are inappropriate as a verifiable hook for resolving the edges in a globally distributed property graph. This requires resolving both nodes and edges. To enable both the node and its connecting edge to be globally uniquely resolvable, each Edge's block must also have a SAID, `d`, field. Recall that a SAID is a cryptographic digest. Therefore, it will universally and uniquely identify an edge with a given set of properties [[ref: Hash]], including the node it points to. 

Thus, a given ACDC with its edges may be universally uniquely resolvable as a graph fragment of a larger graph.  Moreover, because each ACDC with edges, i.e., a graph fragment, may be independently sourced and securely attributed, a distributed property graph can be securely assembled and verified fragment by fragment. To summarize, these features enable ACDCs to be used as securely attributed fragments of a globally distributed property graph (PG). This further enables such a property graph so assembled to serve as a global verifiable knowledge graph that crosses trust domains [[ref: PGM]] [[ref: Dots]] [[ref: KG]]. 

The universal uniqueness of the ACDC SAIDs (nodes) and their Edge SAIDs enable the simplified discovery of ACDCs via service endpoints. The discovery of a service endpoint URL that provides database access to a copy of the ACDC may be bootstrapped via an OOBI (Out-Of-Band-Introduction) that links the service endpoint URL to the SAID of the ACDC or by the SAID of the Edge that points to the SAID of that ACDC [[ref: OOBI]]. Alternatively, the Issuer may provide as an attachment at the time of issuance a copy of the referenced ACDC. In either case, after a successful exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced ACDCs as nodes in the edge sections of all referenced ACDCs. That Issuee will then have everything it needs to make a successful disclosure to some other Disclosee. This is the essence of Percolated discovery [[ref: OOBI]].

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/26
:::




#### Edge-group

The reserved field labels for an Edge-group are detailed in the table below. 

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Optional, self-referential fully qualified cryptographic digest of enclosing Edge-group block. |
|`u`| UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`o`| Operator| Optional as an m-ary operator on the Edges in the Edge-group. Enables expression of the edge logic on edge subgraph.|
|`w`| Weight| Optional property for nested Edges or Edge-groups for weighted average `WAVG` operator. Enables expression weighted average on Edge or Edge-group sub-graph.|

When present, the order of appearance of these fields is as follows: `[d, u, o, w]'.

An Edge-group shall not have a node, `n`, field. 

##### SAID, `d` field
The SAID, `d` field is optional but when it appears it shall appear as the first field in the Edge-group block. The value of this field shall be the SAID of its enclosing block.

##### UUID, `u` field
The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Edge-group block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's sub-schema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's sub-schema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Operator, `o` field
The Operator, `o` field must appear immediately following the SAID, `d` field,  and UUID, `u` field (when present) in the Edge-group block. The Operator field in an Edge-group block is an aggregating (m-ary) operator on all the nested labeled Edges or Edge-groups that appear in its block. This differs from the Operator, `o` field in an Edge block (see below).

The m-ary operators are defined in the table below:

| M-ary Operator | Description | Default|
|:-:|:--|:--|:--|
|`AND`| Logical AND of the validity of the edge-group members. Edge-group is valid only if all members are valid. | Yes |
|`OR`| Logical OR of the validity of the edge-group members. Edge-group is valid if all members are valid. | No |
|`NAND`| Logical NAND of the validity of the edge-group members. Edge-group is valid only if not all members are valid. | No |
|`NOR`| Logical NOR of the validity of the edge-group members. Edge-group is valid only if all members are invalid. | No |
|`AVG`| Arithmetic average of a given edge-group member property. Averaged property is defined by the schema or EGF. | No |
|`WAVG`| Weighted arithmetic average of a given edge-group member property. Weight is given by the `w` field. Averaged property is defined by the schema or EGF. | No |

When the Operator, `o`, field is missing in an edge-group block, the default value for the Operator, `o`, field shall be the `AND` operator.

The actual logic for interpreting the validity of a set of chained or treed ACDCs is EGF-dependent.  But as a default, at least at the time of issuance, one may interpret a set of chained (treed) ACDCs as a provenance chain (tree) with the default logic explained below. ACDCs in a provenance chain or branch that have expiration dates or are dynamically revocable add a timeliness property to the validation logic in the event that the chain was unbroken at issuance but becomes broken later. The timeliness logic is EGF-dependent. 

When the top-level Edge-group, the Edge Section includes only one Edge, the logic for evaluating the validity of the enclosing ACDC (near node) with respect to the validity of the connected far node ACDC pointed to by that edge may be considered a link in a provenance chain.  When any node in a provenance chain is invalid, an edge pointing to that node is also invalid. If a node has an invalid Edge, then the node is invalid.  To elaborate, a chain of nodes with edges has a head and a tail. The edges are directed from the head to the tail. All links from the node at the head at one end of a chain to the tail at the other end must be valid in order for the node (head) to be valid. If any links between the head and the tail are broken (invalid), then the head is itself invalid. The unary operators (defined below) for edges enable modulation of the validation logic of a given edge/node in a chain of ACDCs.

When the top-level Edge-group, the Edge Section includes more than one Edge directly or indirectly (as nested Edge(s) in nested Edge-group), then the logic for evaluating the validity of the enclosing ACDC (near node) with respect to the validity of all the connected far node ACDCs pointed to by those edges may be a provenance tree.  Instead of a single chain from the head to a single tail, we have a tree with the truck at the head and branches as chains of directed edges that each point to a branch tail (leaf) node. To clarify, each branch is a chain from head to branch tail.  All branches from the head must be valid for the head node to be valid. The m-ary operators (defined above), in combination with the unary operators (defined below), allow modulation of the validation aggregation logic of groups of edges/nodes at each branch in a tree of ACDCs.

##### Weight, `w` field
The Weight, `w` field must appear immediately following all of the SAID, `d` field,  UUID, `u` field (when present), and Operator, `o` field  (when present) in the Edge-group block. The Weight field enables weighted averages with operators that perform some type of weighted average, such as the `WAVG` operator. The top-level Edge-group shall not have a weight, `w` field, because it is not a member of another Edge-group.

A Edge-group with a weight provides an aggregate of weighted directed edges. Weighted directed edges may represent degrees of confidence or likelihood. PGs with weighted, directed edges are commonly used for machine learning or reasoning under uncertainty. The Weight, `w` field provides a reserved label for the primary weight on an Edge group to be applied by the operator of its enclosing Edge-group. To elaborate, many aggregating operators used for automated reasoning, such as the weighted average, `WAVG`, Operator, or ranking aggregation operators, depend on each input's weight. To simplify the semantics for such operators, the Weight, `w`, field is the reserved field label for weighting. Other fields with other labels (labeled Edge-group properties) could provide other types of weights, but having a default label, namely `w`, simplifies the default definitions of weighted operators.

##### Labeled nested edge and edge-group fields

Edge-groups and Edges nested within a given Edge-group appear as labeled fields whose labels are not any of the reserved field labels for either Edge-groups or Edges, namely, `[d, u, n, s, o, w]'. Labeled nested Edge or Edge-group fields must appear after all of any fields with a reserved field label.

Each nested Edge or Edge-group block within an Edge-group including the top-level Edge Section Edge-group shall be labeled with a locally unique non-reserved field label that indicates the type of the nested block. To clarify, each nested block in every Edge-group gets its own field with its own local (to the ACDC) label. The field's value may be either an edge sub-block or when in compact form, a string. The compact forms are defined below.

Note that each nested block shall not include a type field. The type of each block is provided by that associated sub-schema in the Edge Section's sub-schema with a matching label. This is in accordance with the design principle of ACDCs that may be succinctly expressed as "type-is-schema." This approach varies somewhat from other types of property graphs, which often do not have a schema [[ref: PGM]][[ref: Dots]][[ref: KG]]. Because ACDCs have a schema, they leverage it to provide property graph edge types with a cleaner separation of concerns. Notwithstanding this separation, an Edge block may include a constraint on the type of the ACDC to which that Edge points by including the SAID of the schema of the pointed-to ACDC as a property of that edge (see below).  

A main distinguishing feature of a property graph (PG) is that both nodes and edges may have a set of properties [[ref: PGM]][[ref: Dots]][[ref: KG]]. These might include modifiers that influence how the connected node is to be combined or place a constraint on the allowed type(s) of connected nodes. Each Edge's block provides the Edge's properties vis-a-vis a property graph. Additional properties may be inferred from the properties of an enclosing Edge-group's block. Each labeled Edge and Edge-group type is defined by the sub-schema designated by its label. 

#### Edge

An Edge is typically represented as a block (field map). There are two exceptions, however, compact edge form and simple compact edge form. These are define below. The edge subschema is used to differentiate these two compact forms from the block form.

The reserved field labels within an Edge block are defined in the table below.

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Optional, self-referential fully qualified cryptographic digest of enclosing edge map. |
|`u`| UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`n`| Node| Required SAID of the far node ACDC as the terminating point of a directed edge that connects the edge's encapsulating near node ACDC to the specified far node ACDC as a fragment of a distributed property graph (PG).|
|`s`| Schema| Optional SAID of the JSON Schema block of the far node ACDC. |
|`o`| Operator| Optional as either a unary operator on the edge itself or an m-ary operator on the edge-group in edge section. Enables expression of the edge logic on edge subgraph.|
|`w`| Weight| Optional edge weight property that enables default property for directed weighted edges and operators that use weights.|

An Edge block shall have a node, `n`, field. This differentiates an Edge block from an Edge-group block.  The SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, and weight, `w`  fields are optional. To clarify, each Edge block shall have a node, `n`, field and  may have any combination of SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, or weight, `w` fields. When present the order of appearance of these fields is as follows: `[d, u, n, s, o, w]'.


##### SAID, `d` field

The SAID, `d` field is optional but, when present, shall appear as the first field in the Edge block. The value of this field shall be the SAID of its enclosing block.

###### Compact edge

Given that an individual edge's property block includes a SAID, `d`, field, a compact representation of the edge's property block is provided by replacing it with its SAID. This is called a compact edge. The schema for that edge's label shall indicate that the edge value is the edge block SAID by using a `oneOf` composition of the compact form and the expanded form. This may be useful for compacting complex edges with many properties and then expanding them later. When the edge block also includes a UUID, `u` field then compating also hides the edge properties for later disclosure. A compact edge without a UUID, `u` field is a public compact edge.  A compact edge with a UUID, `u` field is a private compact edge. 

##### UUID, `u` field

The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Edge block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's sub-schema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's sub-schema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

The absence of the UUID, `u` field in an Edge block makes that edge a Public Edge. 
The presence of the UUID, `u` field in an Edge block makes that Edge a Private Edge.  A Private Edge in compact form, i.e., a Compact Private Edge, enables a presenter of that ACDC to make a verifiable commitment to the ACDC attached to the edge without disclosing any details of that ACDC, including the ACDC's SAID. Private ACDCs (nodes) and Private Edges may be combined to better protect the privacy of the information in a distributed property graph.


##### Node, `n` field

When an edge block does not include a SAID, `d` field, then the node, `n` field must appear as the first field in the block. 

The value of the required node, `n` field, is the SAID of the ACDC to which the edge connects, i.e., the node, `n` field indicates, designates, references, links, or "points to" another ACDC called the far node. To clarify, the edge is directed from the near node, i.e., the ACDC in which the edge block resides, to the far node, which is the ACDC indicated by the value of node, `n` field of that block. The edges and nodes form a directed acyclic graph (DAG). 

In order for a given Edge to be valid, at the very least, a Validator shall confirm that the SAID of the provided far node ACDC matches the node, `n` field value given in the near node ACDC edge block and shall confirm that the provided far node ACDC satisfies its own schema. When the edge block has a schema, `s` field is present (see below), then the far node shall also validate against the schema indicated by the near node edge's schema, `s` field value.


###### Simple compact edge

When an Edge sub-block has only one field, that is, its node, `n` field, i.e., it has no other properties, then the edge block may use an alternate simplified, compact form where the labeled edge field value is the value of its node, `n,` field. The edge is, therefore, public.  This enables the very compact expression of simple public edges. The schema for that edge's label shall indicate that the edge value is a far node SAID string and use a `oneOF` composition whose expanded block has only a Node, `n` field with the far node SAID as its value. 

##### Schema, `s` field

When present, the schema `s` field must appear immediately following the node `n` field in the edge sub-block. The schema, `s` field provides an additional constraint on the far node ACDC. The far node ACDC shall also validate against an edge block schema, `s` field when present.  To clarify, the Validator, after validating that the provided far node ACDC indicated by the node, `n` field satisfies its (the far ACDC's) own schema, shall also confirm that far node ACDC passes schema validation with respect to the edge's `s` field value. This validation is simplified whenever the SAID of the far node ACDC schema matches the SAID fo the edge's schema, `s` field. Then, only one schema validation has to be performed. When the schema SAIDs differ, then two schema validation runs have to be performed. The edge schema, `s` field enables a given Issuer of an ACDC to force forward compatibility constraints on old ACDCs to which a new issuance is chained.

##### Operator, `o` field

The Operator, `o` field must appear immediately following the SAID, `d` field, UUID, `u` field, node, `n` field, or schema, `s` field  (when present) in the Edge block. The Operator, `o`, field value in an Edge block is a unary operator on the Edge itself. When more than one unary operator is applied to a given Edge, then the value of the Operator, `o`, field is a list of those unary operators. When multiple unary operators appear in the list, and there is a conflict between operators, the latest operator among the conflicting operators in the list takes precedence. This differs from the Operator, `o` field in an Edge-group block (see above).

The unary operators are defined in the table below:

| Unary Operator | Description | Default|
|:-:|:--|:--|:--|
|`I2I`| Issuer-To-Issuee, The Issuer AID of this ACDC shall be the Issuee AID of the node this Edge points to.  | Yes |
|`NI2I`| Not-Issuer-To-Issuee, The Issuer AID of this ACDC may or may not be the Issuee AID of the node that this Edge points to. |  No |
|`DI2I`| Delegated-Issuer-To-Issuee, The Issuer AID of this ACDC must be either the Issuee AID or a delegated AID of the Issuee AID of the node this edge points to. | No |
|`NOT`| Logical NOT. The validity of the node this edge points to is inverted. If valid, then not valid. If invalid then valid.  | No |

When the Operator, `o`, field is missing or empty or is present but does not include any of the `I2I`, `NI2I` or `DI2I` Operators then:

- If the node pointed to by the edge is a targeted ACDC, i.e., has an Issuee, then the  `I2I` Operator shall be appended to the Operator, `o`, field's effective list value.

- If the node pointed to by the edge block is an Untargeted ACDC i.e., does not have an Issuee, then the `NI2I` operator shall be appended to the Operator, `o`, field's effective list value.


Many ACDC chains use targeted ACDCs (i.e., have Issuees). A chain of Issuer-To-Issuee-To-Issuer targeted ACDCs in which each Issuee becomes the Issuer of the next ACDC in the chain can be used to provide a chain-of-authority. A common use case of a chain-of-authority is a delegation chain for authorization.

The `I2I` unary operator, when present, means that the Issuer AID of the current ACDC in which the edge resides must be the Issuee AID of the node to which the edge points. Therefore, to be valid, the ACDC node pointed to by this edge shall be a Targeted ACDC. This is the default value when the operator 'o' field value is missing or empty.

The `NI2I` unary operator, when present, removes or nullifies any requirement expressed by the `I2I` operator described above. In other words, any requirement that the Issuer AID of the current ACDC in which the edge resides must be the Issuee AID, if any, of the node the edge points to is relaxed (not applicable). To clarify, when operative (present), the `NI2I` Operator means that both an Untargeted ACDC or Targeted ACDC, as the node pointed to by the edge, may be valid even when untargeted or if targeted even when the Issuer of the ACDC in which the edge appears is not the Issuee AID, of that node to which the edge points.

The `DI2I` unary Operator, when present, expands the class of allowed Issuer AIDs of the node the edge resides in to include not only the Issuee AID but also any delegated AIDS of the Issuee of the node to which the edge points.  Therefore, to be valid, the ACDC node pointed to by this edge shall be a Targeted ACDC.

The `NOT` unary Operator, when present, inverts the validation truthiness of the node pointed to by this Edge. If this Edge's far node ACDC is invalid, then the presence of the `NOT` operator makes this Edge valid. Conversely, if this Edge's far node ACDC is valid, then the presence of the `NOT` operator makes this Edge invalid.   

###### Weight, `w` field.

The Weight, `w` field must appear immediately following the SAID, `d` field, UUID, `u` field, Node, `n` field, Schema, `s` field, or Operator, `o` field  (when present) in the Edge block. The Weight field enables weighted direct edges. The weighted directed edges within an enclosing Edge-group may be aggregated when that Edge-group's operator performs some type of weighted average.

Weighted directed edges may represent degrees of confidence or likelihood. PGs with weighted, directed edges are commonly used for machine learning or reasoning under uncertainty. The Weight, `w` field provides a reserved label for the primary weight on an Edge. To elaborate, many aggregating operators used for automated reasoning, such as the weighted average, `WAVG`, Operator, or ranking aggregation operators, depend on each input's weight. To simplify the semantics for such operators, the Weight, `w` field is the reserved field label for weighting. Other fields with other labels (labeled Edge properties) could provide other types of weights, but having a default label, namely `w` simplifies the default definitions of weighted operators.

##### Labeled property fields

Edge property fields appear as labeled fields whose labels are not any of the reserved field labels for either Edge-groups or Edges, namely, `[d, u, n, s, o, w].' Labeled property fields must appear after all of any fields with a reserved field label.



#### Edge Section Examples

Consider four different ACDCs in compact form (see below). The Issuer of the first is named Amy with AID, `EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM`, the Issuer of the second is named Bob with AID, `EFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBrAqjsK`, the Issuer of the third is named Cat with AID, `EDIPMvklXKhmkPreYpZfzBrAqjsKFk66jpf3uFv7An2E`, and the Issuer of the fourth is named Dug with AID, `EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr`. Notice that the AID of each Issuer appears in the Issuer, `i` field of its respective ACDC below.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "u":  "0ANghkDaG7OY1wjaDAE0qHcg",
  "i":  "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

Issued by Bob:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "ECJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2BBWNHdSX",
  "u":  "0AG7OY1wjaDAE0qHcgNghkDa",
  "i":  "EFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBrAqjsK",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EGeIZ8a8FWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPqG",
  "a":  "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9",
  "r":  "EMORH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3"
}
```

Issued by Cat:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EK0neuniccMBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5",
  "u":  "0ADAE0qHcgNghkDaG7OY1wja",
  "i":  "EDIPMvklXKhmkPreYpZfzBrAqjsKFk66jpf3uFv7An2E",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EFWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8",
  "a":  "EIr9Bf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwL",
  "r":  "EBe71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOL"
}
```

Issued by Dug:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "u":  "0AHcgNghkDaG7OY1wjaDAE0q",
  "i":  "EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4re",
  "a":  "EFrn9y2PYgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lk",
  "r":  "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR"
}
```



##### Two edges

Suppose that the Edge Section of the ACDC issued by Amy, when expanded, has two edges labeled `poe` for proof-of-entitlement and `data`.  The `poe` edge links back to the ACDC issued by Bob's AID and the `data` edge links back to the ACDC issued by Cat's AID. 

Edge section expanded:

```json
{
  "e":
  {
    "d": "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
    "u": "0AwjaDAE0qHcgNghkDaG7OY1",
    "poe":
    {
      "d": "E2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn9y",
      "u": "0ANghkDaG7OY1wjaDAE0qHcg",
      "n": "ECJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2BBWNHdSX",
      "s": "ELIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw"
    },
    "data":
    {
      "d": "ELxUdYerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOc",
      "u": "0ADAE0qHcgNghkDaG7OY1wja",
      "n": "EK0neuniccMBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5",
      "s": "EHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_N",
      "o": "NI2I"
    }
  }
}
```

Edge section (compact private edges):

```json
{
  "e":
  {
    "d": "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
    "u": "0AwjaDAE0qHcgNghkDaG7OY1",
    "poe": "E2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn9y",
    "data": "ELxUdYerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOc"
  }
}
```

Edge section sub-schema:

```json
"e":
{
  "description": "edge section",
  "oneOf":
  [
    {
      "description": "edge section SAID",
      "type": "string"
    },
    {
      "description": "edge section detail",
      "type": "object",
      "required":
      [
        "d",
        "u",
        "poe",
        "data"
      ],
      "properties":
      {
        "d":
        {
          "description": "edge section SAID",
          "type": "string"
        },
        "u":
        {
          "description": "edge section UUID",
          "type": "string"
        },
        "poe":
        {
          "description": "proof of entitlement edge",
          "oneOf":
          [
            {
              "description": "compact form edge detail SAID",
              "type": "string"
            },
            {
              "description": "edge detail",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "n",
                "s"
              ],
              "properties":
              {
                "d":
                {
                  "description": "edge SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "edge UUID",
                  "type": "string"
                },
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s":
                {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "ELIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw",
                }
              },
              "additionalProperties": false
            }
          ]
        },
        "data":
        {
          "description": "data edge",
          "oneOf":
          [
            {
              "description": "compact form edge detail SAID",
              "type": "string"
            },
            {
              "description": "data edge detail",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "n",
                "s",
                "o"
              ],
              "properties":
              {
                "d":
                {
                  "description": "edge SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "edge UUID",
                  "type": "string"
                },
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s":
                {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "EHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_N",
                },
                "o":
                {
                  "description": "unary edge operator",
                  "type": "string"
                },
              },
              "additionalProperties": false
            },
          ]
        }
      },
      "additionalProperties": false
    }
  ]
}
```

Notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the Node, `n` field value of the `bob` edge block is the value of the SAID, `d` field of the ACDC issued by Bob, and the Node, `n` field value of the `cat` edge block is the value of the SAID, `d` field of the ACDC issued by Cat. Further, notice that the top-level Edge-group of the ACDC issued by Amy has no operator field. This means that the default m-ary operator `AND` is applied. Therefore Amy's ACDC is invalid unless both the linked ACDCs issued by Bob and Cat are valid. Moreover, notice that the Edge block labeled `poe` in Amy's ACDC has no operator, `o` field. This means that the default unary operator `I2I` is applied. This means that Bob's ACDC must designate Amy's AID as the Issuee in order for this edge to be valid. Finally, notice that the Edge block labeled `data` in Amy's ACDC has an operator, `o` field value of `NI2I`. This means that there is no requirement that Cat's ACDC designates Amy's AID as the Issuee in order for this edge to be valid. If it does, fine; if not, also fine.

Suppose that the expanded Attribute section of the ACDC issued by Bob is as follows:

```json
"a":
{
  "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "u": "0ADAE0qHcgNghkDaG7OY1wja",
  "i": "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
}
```

Because the value of the Issuee, `i`, field in Bob's attribute section is Amy's AID, the default `I2I` operator on Amy's edge labeled `poe` is satisfied. Thus, Amy's ACDC validates with respect to its edges.

Both Edges can be individually compacted and private because they include both `d` and `u` fields. The schema allows this compact edge form with a `oneOf` composition on each of the edges. Notice that in the compact edge form the value of each labeled edge field is the SAID, `d` field value of its expanded form.  To elaborate, the Edge section can be expressed in one of three forms. These are:
- compact private form, as a whole, because its schema uses the `oneOf` composition.
- partially expanded form with compact private edges because each edge's sub-schema uses the `oneOf` composition.
- fully expanded form with fully expanded edge blocks because of the combination of `oneOf` compositions at both the section and edge levels.

##### Nested edge group
 
In contrast to the previous example, this example shows a nested Edge-group in the ACDC issued by Amy. Amy's Edge Section when expanded, has three edges labeled `poe`, `sewer`, and `gas` as shown below, where each of these labeled edges links back to the ACDCs issued respectively by Bob's, Cat's, and Dug's AIDs. The nested Edge-group has label `poa` for proof-of-address. Some of the field values in the compact version of the ACDC issued by Amy must change because the edge section and schema are both different.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EHdSXCJnBWNFJL5OuQPyM5K0neunicIXOf2BcMBdXt3g",
  "u":  "0ADaG7OY1wjaDAE0qHcgNghk",
  "i":  "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EFWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "EJtQIYPvAu6DZIl3MOARH3dCdoFOLe71iheqcywJcnjt",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```


Edge section:
```json
{
  "e":
  {
    "d": "EJtQIYPvAu6DZIl3MOARH3dCdoFOLe71iheqcywJcnjt",
    "u": "0AwjaDAE0qHcgNghkDaG7OY1",
    "poe":
    {
      "d": "E2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn9y",
      "u": "0ANghkDaG7OY1wjaDAE0qHcg",
      "n": "ECJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2BBWNHdSX",
      "s": "ELIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw"
    },
    "poa":
    {
      "d": "E2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn9y",
      "u": "0ANghkDaG7OY1wjaDAE0qHcg",
      "o": "OR",
      "sewer":
      {
        "d": "ELxUdYerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOc",
        "u": "0ADAE0qHcgNghkDaG7OY1wja",
        "n": "EK0neuniccMBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5",
        "s": "EHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_N",
      },
      "gas":
      {
        "d": "EHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_N",
        "u": "0AAE0qHcgNghkDaG7OY1wjaD",
        "n": "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
        "s": "EFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lk",
      }
    }
  }
}
```

Edge section sub-schema:

```json
"e":
{
  "description": "edge section",
  "oneOf":
  [
    {
      "description": "edge section SAID",
      "type": "string"
    },
    {
      "description": "edge detail",
      "type": "object",
      "required":
      [
        "d",
        "u",
        "poe",
        "poa"
      ],
      "properties":
      {
        "d":
        {
          "description": "edge section SAID",
          "type": "string"
        },
        "u":
        {
          "description": "edge section UUID",
          "type": "string"
        },
        "poe":
        {
          "description": "entitlement edge",
          "type": "object",
          "required":
          [
            "d",
            "u",
            "n",
            "s"
          ],
          "properties":
          {
            "d":
            {
              "description": "edge SAID",
              "type": "string"
            },
            "u":
            {
              "description": "edge UUID",
              "type": "string"
            },
            "n":
            {
              "description": "far node SAID",
              "type": "string"
            },
            "s":
            {
              "description": "far node schema SAID",
              "type": "string",
              "const": "ELIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw",
            }
          },
          "additionalProperties": false
        },
        "poa":
        {
          "description": "proof of address group",
          "type": "object",
          "required":
          [
            "d",
            "u",
            "o",
            "sewer",
            "gas"
          ],
          "properties":
          {
            "d":
            {
              "description": "edge SAID",
              "type": "string"
            },
            "u":
            {
              "description": "edge UUID",
              "type": "string"
            },
            "o":
            {
              "description": "m-ary group operator",
              "type": "string",
              "const": "OR"
            },
            "sewer":
            {
              "description": "sewer address edge",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "n",
                "s"
              ],
              "properties":
              {
                "d":
                {
                  "description": "edge SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "edge UUID",
                  "type": "string"
                },
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s":
                {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "EHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_N",
                },
              },
              "additionalProperties": false
            },
            "gas":
            {
              "description": "gas address edge",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "n",
                "s"
              ],
              "properties":
              {
                "d":
                {
                  "description": "edge SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "edge UUID",
                  "type": "string"
                },
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s":
                {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "EFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lk",
                },
              },
              "additionalProperties": false
            }
          },
          "additionalProperties": false
        },
      },
      "additionalProperties": false
    }
  ]
}
```

Notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the Node, `n` field value of the `poe` edge block is the value of the SAID, `d` field of the ACDC issued by Bob, the Node, `n` field value of the `sewer` edge block is the value of the SAID, `d` field of the ACDC issued by Cat, and the Node, `n` field value of the `gas` edge block is the value of the SAID, `d` field of the ACDC issued by Dug. Further, notice that the top-level Edge-group of the ACDC issued by Amy has no operator field. This means that the default m-ary operator `AND` is applied. This top-level Edge-group includes one Edge labeled `poe` and a nested Edge-group labeled `poa`. This nested edge group has two Edges labeled `sewer` and `gas`. The Edge-group's Operator, `o` field value is `OR`. This means that the Edge-group is valid if either of its edges is valid. The unary operators on the `poe`, `sewer`, and `gas` edges are the default `I2I` because the Operator, `o` field is missing in each of the associated Edge blocks. This means that each of the ACDCs issued by Bob, Cat, and Dug must designate Amy's AID as the Issuee in order for the associated edge to be valid. But as long as the `poe` edge is valid, only one of the edges, `sewer` or `gas`, must be valid for Amy's ACDC to be valid with respect to its edges.

To clarify, with this version of the Edge Section,  Amy's ACDC is valid with respect to its edges if the ACDC issued by Bob is valid, and either Cat's or Dug's ACDCs are valid.  Amy's Edge section with nested Edge-group provides a sub-graph with an `AND-OR` logic tree on its three edges. This is suitable for many types of business logic, such as KYC, for example, where the combination of a proof of entitlement (`poe`) and a proof of one of two types of addresses (`sewer` or `gas`) is required.

The three Edges and the nested Edge-group could each be individually compacted and private because they include both `d` and `u` fields. To simplify the example, however, the `oneOF` componsition was not applied to the individual edges and nested edge group. Therefore the simplified schema only allows the expanded form of the individual edges and nested edge group.  Nonetheless, the Edge section, as a whole can be expressed in compact private form because its schema uses the `oneOf` composition. 

##### Compact public edge section example

Suppose instead Amy is not concerned about privacy at either the section or the individual edge and edge group level. Amy therefore could benefit from using an expanded Edge Section that is more compact. Furthermore  Amy's ACDC may not benefit from specifying a different schema constraint on the far nodes of its edges. Therefore, compared to the example above, several fields could be eliminated. These include all the `u` fields, all but the top-level Edge Section `d` field, and all the `s` fields.


Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EBWNFJL5OuQPyM5K0neunicIXOf2BcMBdXt3gHdSXCJn",
  "u":  "0AG7OY1wjaDAE0qHcgNghkDa",
  "i":  "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EGGeIZ8a8FWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPq",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```


Edge section (simple compact edges):
```json
{
  "e":
  {
    "d": "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
    "poe": "ECJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2BBWNHdSX",
    "poa":
    {
      "o": "OR",
      "sewer": "EK0neuniccMBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5",
      "gas": "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B"
    }
  }
}
```

Edge section sub-schema:

```json
"e":
{
  "description": "edge section",
  "oneOf":
  [
    {
      "description": "edge section SAID",
      "type": "string"
    },
    {
      "description": "edge detail",
      "type": "object",
      "required":
      [
        "d",
        "poe",
        "poa"
      ],
      "properties":
      {
        "d":
        {
          "description": "edge section SAID",
          "type": "string"
        },
        "poe":
        {
          "description": "entitlement edge",
          "oneOf":
          [
            {
              "description": "simple compact form far node SAID",
              "type": "string"
            },
            {
              "description": "edge detail",
              "type": "object",
              "required":
              [
                "n",
              ],
              "properties":
              {
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          ]
        },
        "poa":
        {
          "description": "proof of address group",
          "type": "object",
          "required":
          [
            "o",
            "sewer",
            "gas"
          ],
          "properties":
          {
            "o":
            {
              "description": "m-ary group operator",
              "type": "string",
              "const": "OR"
            },
            "sewer":
            {
              "description": "sewer address edge",
              "oneOf":
              [
                {
                  "description": "simple compact form far node SAID",
                  "type": "string"
                },
                {
                  "description": "edge detail",
                  "type": "object",
                  "required":
                  [
                    "n",
                  ],
                  "properties":
                  {
                    "n":
                    {
                      "description": "far node SAID",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            },
            "gas":
            {
              "description": "gas address edge",
              "oneOf":
              [
                {
                  "description": "simple compact form far node SAID",
                  "type": "string"
                },
                {
                  "description": "edge detail",
                  "type": "object",
                  "required":
                  [
                    "n",
                  ],
                  "properties":
                  {
                    "n":
                    {
                      "description": "far node SAID",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            }
          },
          "additionalProperties": false
        },
      },
      "additionalProperties": false
    }
  ]
}
```

Notice how much more compact is the edge section in partially expanded form. As before, notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the value of the `poe` field is the value of the SAID, `d` field of the ACDC issued by Bob. This is the simple compact form of an edge described above. Likewise for the `sewer` field value and the `gas` field value which are respectively the value of the SAID, `d` field of the ACDCs issued by Cat and Dug. All the Edges and nested Edge-groups are public because they do include a `u` field. The schema uses the `oneOf` composition operator on all three edges. This indicates that the compact form is simple compact form because their expanded block form only includes a Node, `n` field and not a SAID, `d` field.

Otherwise, this example's semantics are the same as the previous example, just more compact.


##### Examples Summary

As the examples above have shown, the Edge Section syntax enables the composable and extensible but efficient expression of aggregating (m-ary) and unary operators both singly and in combination as applied to nestable groups of edges.  The intelligent defaults for the Operator, `o`, field, namely, `AND` for m-ary operators and `I2I` for unary operators, means that in many use cases, the Operator, `o`, field, does not even need to be present. This syntax is sufficiently general in scope to satisfy the contemplated use cases, including those with more advanced business logic. 


### Rule Section  

The purpose of the rule section is to provide a set of rules or conditions as a Ricardian Contract [[ref: RC]]. The important features of a Ricardian contract are that it be both human and machine-readable and referenceable by a cryptographic digest. A JSON-encoded document or block, such as the Rule section block, is a practical example of both a human and machine-readable document.  The rule section's top-level SAID, `d` field provides the digest.  This provision supports the bow-tie model of RC. 

The Rule Section includes labeled nested blocks called rules that provide the legal language (terms , conditions, definitions etc). The labeled clauses can be structured hierarchically, where each rule, in turn, can include nested labeled rules. The labels on the rules may follow a structured naming or numbering convention. These provisions enable the rule section to satisfy the features of an RC. 

#### Block types

There are two types of field maps or blocks that may appear as values of fields within the Rule Section, `r` field either at the top level of the Rule block itself or nested. These are Rules or Rule-groups. Rules may only appear as locally unique labeled (using non-reserved labels)  blocks nested within an Rule-Group. There are two exceptional forms for Rules, compact and simple compact form. In these two forms, the labeled Rule field value is not a block but a string. These exceptions are defined below.

The Rule Section is the top-level Rule-group. 

Nested Rule-groups may only appear as locally unique labeled blocks nested within another Rule-group. The block type, Rule or Rule-group, is indicated by its corresponding labeled sub-schema, with the exception of the top-level Rule-group, which is the Rule Section and is indicated by the Rule Section sub-schema. A Rule-group is indicated by the presence of one or more non-reserved labeled fields whose value represents a nested Rule or Rule-Groups. 

#### Rule discovery 

In compact form, the discovery of either the Rule section as a whole or a given Rule or Rule-group begins with the provided SAID. Because the SAID, `d`, field of any block is a cryptographic digest with high collision resistance, it provides a universally unique identifier to the referenced block details (whole rule section or individual rule). The discovery of a service endpoint URL that provides database access to a copy of the rule section or to any of its rules or rule-groups may be bootstrapped via an OOBI that links the service endpoint URL to the SAID of the respective block [[ref: OOBI]]. Alternatively, the Issuer may provide as an attachment at issuance a copy of the referenced contract associated with the whole rule section or any rule. In either case, after a successful issuance exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced contracts in whole or in part of all ACDCs so issued. That Issuee will then have everything subsequently needed to make a successful presentation or disclosure to a Disclosee. This is the essence of percolated discovery.

#### Rule-group

The reserved field labels for Rule-groups are detailed in the table below. 

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Optional Self-referential fully qualified cryptographic digest of enclosing block. |
|`u`| UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`l`| Legal Language| Optional legal language for the Rule-group.|

When present, the order of appearance of these fields is as follows: `[d, u, l]`.

A Rule-group may have a Legal, `l`, field and may have a SAID, `d` field. When the Rule-group has a SAID, `d` field it may also have a UUID, `u` field. A Rule-group may have one or more other labeled fields whose values represent nested Rules or Rule-groups. In this sense, a Rule-group is an intermediate node in a sub-graph of Rule-groups and Rules.

##### SAID, `d` field
The SAID, `d` field is optional but when it appears it shall appear as the first field in the Rule-group block. The value of this field shall be the SAID of its enclosing block. To elaborate, when the Rule-group is the top-level Rule Section its SAID is the same SAID used as the compacted value of the Rule Section, `r` field that appears at the top level of the ACDC. When not the top-level Rule-group, a given nested Rule-group's SAID, `d` field enables a verifiable globally unique reference to that nested Rule-group, not merely the whole contract as given by the Rule section's top-level SAID, `d`, field.

##### UUID, `u` field
The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Rule-group block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's sub-schema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's sub-schema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Labeled nested rule and rule-group fields

Rules and Rule-group nested within a Rule-group appear as labeled fields whose labels are not any of the reserved field labels for a Rule-group, namely, `[d, u, l]`. Labeled nested Rule or Rule-group fields must appear after all of any fields with a reserved field label. 

To elaborate, each nested Rule or Rule-group block shall be labeled with a locally unique non-reserved field label that indicates the type of the nested block. To clarify, each nested block gets its own field with its own local (to the ACDC Rule Section) label. The field's value may be either the Rule or Rule-group block or, in compact form, a string. The compact forms are defined below.

Note that each nested block shall not include a type field. The type of each block is provided by that associated nested sub-schema with a matching label. This is in accordance with the design principle of ACDCs that may be succinctly expressed as "type-is-schema." This approach varies somewhat from other types of property graphs, which often do not have a schema [[ref: PGM]][[ref: Dots]][[ref: KG]]. Because ACDCs have a schema, they leverage it to provide property graph types with a cleaner separation of concerns.   

A main distinguishing feature of a property graph (PG) is that both nodes and edges may have a set of properties [[ref: PGM]][[ref: Dots]][[ref: KG]].  Each Rule-group's block provides its additional properties vis-a-vis a property graph as labeled fields. Additional properties may be inferred from the properties of an enclosing Rule-group block. Each labeled rule type is defined by the sub-schema designated by its label. 


#### Rule

The reserved field labels for a Rule block are detailed in the table below.

| Label | Title | Description |
|:-:|:--|:--|
| `d` | Digest (SAID) | Optional self-referential fully qualified cryptographic digest of enclosing block. |
| `u` | UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
| `l` | Legal Language| The actual legal language for the clause.|

When present, the order of appearance of these fields is as follows: `[d, u, l]`.

A Rule shall have a Legal, `l`, field. And may have a SAID, `d` field. When the Rule has a SAID, `d` field, it may also have a UUID, `u` field. A Rule shall not have any other fields. In this sense, a Rule is a terminal node in a sub-graph of Rule-groups and Rules.

##### SAID, `d` field
The SAID, `d` field is optional, but when it appears, it shall appear as the first field in the Clause block. The value of this field shall be the SAID of its enclosing block. A Rule's SAID enables a verifiable globally unique reference to that rule, not merely the whole contract as given by the Rule section's top-level SAID, `d`, field.

##### Compact rule

Given that an individual Rule block includes a SAID, `d` field, a compact representation of the Rule's block is provided by replacing it with its SAID. This is called a compact rule. The schema for that clause's label shall indicate that the clause field value is the clause block SAID by using a `oneOf` composition of the compact form and the expanded form. This may be useful for compacting lengthy clauses and then expanding them later. When the clause block also includes a UUID, `u` field, then compacting also hides the clause's legal language for later disclosure. A compact clause without a UUID, `u` field is a public compact clause.  A compact clause with a UUID, `u` field is a private compact clause. 


##### UUID, `u` field
The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Rule Section block following the SAID, `d` field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's sub-schema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's sub-schema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Legal, `l` field

The legal language, `l`, field in each clause block provides the associated legal language as a string.


##### Simple compact rule

When a Rule block has only one field, that is, its legal, `l` field, i.e., it has no other properties, then the rule block may use an alternate simplified, compact form where the labeled rule field value is the value of its legal, `l` field. The rule is, therefore, public.  This enables the very compact expression of simple public rules. The schema for that rule's label shall indicate that the rule's compact value is the value of its Legal, `l` field in expanded form and use a `oneOF` composition whose expanded block has only a Legal, `l` field. 



#### Rule section examples


##### Private rules

Some Rules and Rule-groups, as opposed to the Rule Section as a whole, may benefit from confidential disclosure. Recall that individual Rule and Rule-group blocks may have their own SAID, `d`, field and UUID, `u,` field. To clarify, a Rule or Rule-group block with both a SAID, `d`, and UUID, `u` fields, where that UUID has sufficiently high entropy, protects the compact form of that block from discovery via a rainbow table attack merely from its SAID and sub-schema [[ref: RB]] [[ref: DRB]]. Therefore, such a Rule or Rule-group may kept hidden until later disclosure. These are called private Rules or Rule-groups. The following example has an independently hidable Rule-group and Rules.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EBWNFJL5OuQPyM5K0neunicIXOf2BcMBdXt3gHdSXCJn",
  "u":  "0AG7OY1wjaDAE0qHcgNghkDa",
  "i":  "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EGGeIZ8a8FWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPq",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

Rule section expanded:

```json
"r":
{
  "d": "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB",
  "u": "0ADaG7OaDAE0qHcgY1Nghkwj",
  "disclaimers":
  {
    "d": "ELIr9Bf7V_NAwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw",
    "u": "0AHcgY1NghkwjDaG7OaDAE0q",
    "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:",
    "warrantyDisclaimer":
    {
      "d": "EBgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
      "u": "0AG7OY1wjaDAE0qHcgNghkDa",
      "l": "Issuer provides this ACDC on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE"
    },
    "liabilityDisclaimer":
    {
      "d": "ED1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw",
      "u": "0AHcgNghkDaG7OY1wjaDAE0q",
      "l": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    }
  },
  "permittedUse":
  {
    "d": "EEgOcLxUdYerzwLFrn9y2PgveY4-9Ir9Bf7V_NAwY1lk",
    "u": "0ADaG7OY1wjaDAE0qHcgNghk",
    "l": "The person or legal entity identified by the ACDC's Issuee AID (Issuee) agrees to only use the information contained in this ACDC for non-commercial purposes."
  }
}
```

Rule section compact private rules:

```json
"r":
{
  "d": "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB",
  "u": "0ADaG7OaDAE0qHcgY1Nghkwj",
  "disclaimers":
  {
    "d": "ELIr9Bf7V_NAwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw",
    "u": "0AHcgY1NghkwjDaG7OaDAE0q",
    "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:",
    "warrantyDisclaimer": "EBgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
    "liabilityDisclaimer": "ED1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw",
  },
  "permittedUse": "EEgOcLxUdYerzwLFrn9y2PgveY4-9Ir9Bf7V_NAwY1lk"
}
```


Rule section schema:

```json
"r":
{
  "description": "rule section",
  "oneOf":
  [
    {
      "description": "rule section SAID",
      "type": "string"
    },
    {
      "description": "rule detail",
      "type": "object",
      "required":
      [
        "d",
        "u",
        "disclaimers",
        "permittedUse"
      ],
      "properties":
      {
        "d":
        {
          "description": "rule section SAID",
          "type": "string"
        },
        "u":
        {
          "description": "rule section UUID",
          "type": "string"
        },
        "disclaimers":
        {
          "description": "rule group",
          "type": "object",
          "required":
          [
            "d",
            "u",
            "l",
            "warrantyDisclaimer",
            "liabilityDisclaimer"
          ],
          "properties":
          {
            "d":
            {
              "description": "rule group SAID",
              "type": "string"
            },
            "u":
            {
              "description": "rule group UUID",
              "type": "string"
            },
            "warrantyDisclaimer":
            {
              "description": "rule",
              "oneOf":
              [
                {
                  "description": "compact form",
                  "type": "string"
                },
                {
                  "description": "rule detail",
                  "type": "object",
                  "required":
                  [
                    "d",
                    "u",
                    "l",
                  ],
                  "properties":
                  {
                    "d":
                    {
                      "description": "rule SAID",
                      "type": "string"
                    },
                    "u":
                    {
                      "description": "rule UUID",
                      "type": "string"
                    },
                    "l":
                    {
                      "description": "legal language",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            },
            "liabilityDisclaimer":
            {
              "description": "rule",
              "oneOf":
              [
                {
                  "description": "compact form",
                  "type": "string"
                },
                {
                  "description": "rule detail",
                  "type": "object",
                  "required":
                  [
                    "d",
                    "u",
                    "l",
                  ],
                  "properties":
                  {
                    "d":
                    {
                      "description": "rule SAID",
                      "type": "string"
                    },
                    "u":
                    {
                      "description": "rule UUID",
                      "type": "string"
                    },
                    "l":
                    {
                      "description": "legal language",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            }
          },
          "additionalProperties": false
        },
        "permittedUse":
        {
          "description": "rule",
          "oneOf":
          [
            {
              "description": "compact form",
              "type": "string"
            },
            {
              "description": "rule detail",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "l",
              ],
              "properties":
              {
                "d":
                {
                  "description": "rule SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "rule UUID",
                  "type": "string"
                },
                "l":
                {
                  "description": "legal language",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          ]
        },
      },
      "additionalProperties": false
    }
  ]
}
```
Notice that the value of the Rule Section's UUID, `d` field matches the value of the Rule, `r` field in the ACDC issued by Amy. Furthermore, notice that in the compact private rule form the value of the labeled rules is the value of the SAID, `d` field from the expanded form.

#### Simple compact public rules

When there is no benefit to a private Rule section, then its UUID fields are not needed. Moreover for the rules themselves do not benefit from a dedicated SAID, `d` field. Given this change, we can express the Rule section in a compact form with simple compact rules. Recall that in simple, compact form, each rule block shall not have any fields besides the Legal, `l` field. This field value then becomes the value of the labeled Rule block.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "d":  "EBWNFJL5OuQPyM5K0neunicIXOf2BcMBdXt3gHdSXCJn",
  "u":  "0AG7OY1wjaDAE0qHcgNghkDa",
  "i":  "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EGGeIZ8a8FWS7a6s4reAXRZOkogZ2A46jrVPTzlSkUPq",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "EFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3dCdo",
  "r":  "EDZIl3MORH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6"
}
```

Rule section expanded:

```json
"r":
{
  "d": "EDZIl3MORH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6",
  "disclaimers":
  {
    "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:",
    "warrantyDisclaimer":
    {
      "l": "Issuer provides this ACDC on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE"
    },
    "liabilityDisclaimer":
    {
      "l": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    }
  },
  "permittedUse":
  {
    "l": "The person or legal entity identified by the ACDC's Issuee AID (Issuee) agrees to only use the information contained in this ACDC for non-commercial purposes."
  }
}
```

Rule section simple compact private rules:

```json
"r":
{
  "d": "EDZIl3MORH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6",
  "disclaimers":
  {
    "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:",
    "warrantyDisclaimer": "Issuer provides this ACDC on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE",
    "liabilityDisclaimer": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
  },
  "permittedUse": "The person or legal entity identified by the ACDC's Issuee AID (Issuee) agrees to only use the information contained in this ACDC for non-commercial purposes."
}
```


Rule section schema:

```json
"r":
{
  "description": "rule section",
  "oneOf":
  [
    {
      "description": "rule section SAID",
      "type": "string"
    },
    {
      "description": "rule detail",
      "type": "object",
      "required":
      [
        "d",
        "disclaimers",
        "permittedUse"
      ],
      "properties":
      {
        "d":
        {
          "description": "rule section SAID",
          "type": "string"
        },
        "disclaimers":
        {
          "description": "rule group",
          "type": "object",
          "required":
          [
            "l",
            "warrantyDisclaimer",
            "liabilityDisclaimer"
          ],
          "properties":
          {
            "warrantyDisclaimer":
            {
              "description": "rule",
              "oneOf":
              [
                {
                  "description": "simple compact form",
                  "type": "string"
                },
                {
                  "description": "rule detail",
                  "type": "object",
                  "required":
                  [
                    "l",
                  ],
                  "properties":
                  {
                    "l":
                    {
                      "description": "legal language",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            },
            "liabilityDisclaimer":
            {
              "description": "rule",
              "oneOf":
              [
                {
                  "description": "simple compact form",
                  "type": "string"
                },
                {
                  "description": "rule detail",
                  "type": "object",
                  "required":
                  [
                    "l",
                  ],
                  "properties":
                  {
                    "l":
                    {
                      "description": "legal language",
                      "type": "string"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            }
          },
          "additionalProperties": false
        },
        "permittedUse":
        {
          "description": "rule",
          "oneOf":
          [
            {
              "description": "simple compact form",
              "type": "string"
            },
            {
              "description": "rule detail",
              "type": "object",
              "required":
              [
                "l",
              ],
              "properties":
              {
                "l":
                {
                  "description": "legal language",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          ]
        },
      },
      "additionalProperties": false
    }
  ]
}
```




## Disclosure mechanisms and exploitation protection

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/30
:::

An important design goal of ACDCs is to support the sharing of provably authentic data while also protecting against the exploitation of that data. Often, the term privacy protection is used to describe similar properties. However, a narrow focus on privacy protection may lead to problematic design trade-offs. With ACDCs, the primary design goal is not data privacy protection per se but the more general goal of protection from the uncommissioned exploitation of data. In this light, a given privacy protection mechanism may be employed to help protect against data exploitation but only when it serves that more general-purpose and not as an end in and of itself.

### Data privacy

Information or data privacy is defined as the relationship between the collection and dissemination of data, technology, the public expectation of privacy, contextual information norms, and the legal and political issues surrounding them [Information privacy](https://en.wikipedia.org/wiki/Information_privacy). Data privacy is challenging since it attempts to allow the use of data by 2nd and 3rd parties while protecting personal (1st party) privacy preferences and personally identifiable information (PII). The fields of computer security, data security, and information security all design and use software, hardware, and human resources to address this issue. This definition is consistent with privacy viewed from the perspective of 1st party data rights and the role of 2nd parties in the three-party exploitation model defined below. The Trust over IP (ToIP) foundation’s architecture specification phrases privacy protection as answering the question:
 Privacy: will the expectations of each party with respect to the usage of shared information be honored by the other parties?
 
 [Trust over IP (ToIP) Technology Architecture Specification](https://github.com/trustoverip/TechArch/blob/main/spec.md#61-design-goals)

### Three-party exploitation model 

Sustainable privacy is based on a three-party exploitation model [Sustainable Privacy](https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/SustainablePrivacy.pdf). Fundamentally, the goal is to protect the person (data subject) from exploitation via their personal data. In common usage, exploitation is selfishly taking advantage of someone to profit from them or otherwise benefit oneself. So, any unintended usage by any party is potentially exploitive. Intent is with respect to the person (data subject).

In this model, the 1st party is the person (data subject) of the original data. Their data is 1st party data. A 2nd party is the direct recipient of 1st party data as an intended recipient by the 1st party. A 3rd party is any other party who obtains or observes 1st party data but who is not the intended recipient. 

There are two main avenues of exploitation of 1st party data. These are any 2nd party who uses the data in any way not intended by the 1st party and any 3rd party who uses 1st party data. To clarify, any unintended (unpermissioned) use of 1st party data by any 2nd party is naturally exploitive. 

Moreover, because a 3rd party is defined as an unintended recipient, any use of 1st party data by a 3rd party is likewise, by definition, exploitive. 

Furthermore, 1st party data may be conveyed by one 2nd party to another 2nd party (i.e. shared) in a non-exploitive manner when such conveyance and eventual use by the other 2nd party is intended (permitted) by the 1st party.

To elaborate, exploitation based on disclosure is characterized by a Three-party model. The three parties are as follows:

- First-party = Discloser of data.
- Second-party = Disclosee of data received from First party (Discloser).
- Third-party = Observer of data disclosed by First party (Discloser) to Second party (Disclosee).

Typically, protection from direct 3rd-party (Observer) exploitation without the collusion of the 2nd-party (Disclosee) of disclosed data may be provided by encrypting that data such that only the 2nd-party (Disclosee) may decrypt that data. Encryption is one effective mechanism for protecting the confidentiality of disclosed data from non-collusive 3rd-party observation. The detailed description of such mechanisms that are compatible with ACDCs is beyond the scope of this specification. See [SPAC](https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/SPAC_Message.pdf) and {{TSP}} compatible encryption protocols. 

The primary mechanisms by which 2nd parties (Disclosees) erode the data privacy rights of disclosed data are as follows:
	•	Exploitive use of 1st-party (Discloser) data by 2nd parties (Disclosees).
	•	Sharing of 1st-party (Discloser) data by 2nd parties (Disclosees) with 3rd parties (Observers) either overtly (collusive) or inadvertently (leakage).


This model is diagrammed below. 






## Exploitation Protection Mechanisms

### Least disclosure
ACDCs provide several mechanisms designed to help protect against the exploitation of disclosed data. These are based on the principle of least disclosure as follows:

The system should disclose only the minimum amount of information about a given party needed to facilitate a transaction and no more. [[ref: IDSys]]

### Graduated Disclosure

Any given transaction may entail several disclosures that are iterative and incremental, such that one least disclosure facilitates another least disclosure, and so forth. The incremental interactive application of the principle of least disclosure we call Graduated Disclosure. The important insight is that one type of transaction enabled by a given least disclosure is one that specifically enables further disclosure. In other words, disclose enough to enable more disclosure, which in turn may enable even more disclosure.  To clarify, Graduated disclosure enables a potential Discloser to follow the principle of least disclosure by providing the least amount of information i.e., partial, incomplete, or uncorrelatable information needed to further a transaction. This progression of successive least disclosures to enable further disclosures forms a recursive loop of least disclosure-enabled transactions. In other words, the principle of least disclosure may be applied recursively as part of a Graduated disclosure. A contractually protected disclosure, for example, may result from the recursive application of least disclosure transactions.

There are several graduated disclosure mechanisms as follows:

- Compact disclosure
- Metadata disclosure
- Partial disclosure
- Nested partial disclosure
- Full disclosure
- Selective disclosure
- Bulk-issued instance disclosure

As their names suggest, the graduated disclosure mechanisms disclose more or less of an ACDC. A short summary of each mechanism is provided immediately below. More detailed descriptions of each of the graduated disclosure mechanisms are either provided in the ensuing sections or in the Annex.

- Compact disclosure of a block (field map) of data relies on the inclusion in that block of a cryptographic digest of the content (SAID) of that content. Disclosure of the SAID makes a verifiable commitment to its data that may be more fully disclosed later. The schema for the block includes a `oneOf` composition operator that validates against both the compact and full versions of the block.

- Metadata disclosure happens with a Metadata ACDC is used to disclose any part of an ACDC. As defined above, a Metadata ACDC is indicated by the appearance of an empty, top-level UUID, `u`, field. Recall that the purpose of a metadata ACDC is to provide a mechanism for a Discloser to make cryptographic commitments to the metadata of a yet-to-be-disclosed private ACDC without providing any point of correlation to the actual top-level SAID, `d`, the field of that yet-to-be disclosed ACDC. 

- Partial disclosure of a data block relies upon a cryptographic digest (SAID) of the content and a salty nonce (UUID) embedded in that content. The presence of the salty-nonce means that disclosure of its digest (SAID) plus a schema of that content is not enough to discover the actual content. The content remains blinded in spite of disclosure of its SAID until and unless the salty-nonce (UUID) is also disclosed. The schema for the block includes a `oneOf` composition operator that validates against both the compact and full versions of the block.

- Nested partial disclosure of a tree of hierarchical data blocks relies on each nested block embedding both its digest (SAID) and a salty-nonce (UUID). This allows the Partial Disclosure of different branches of the tree at different levels of nesting. The schema for the block includes a `oneOf` composition operator at each level of nesting that validates against both the compact and full versions of the nested block and any nesting levels above it in the tree.

- Full disclosure is disclosure without hiding a given block's content behind SAIDs or salted SAIDs.

- Selective disclosure of a set of data blocks relies on each element embedding its digest (said) and salty-nonce (UUID) as partially disclosable elements. The schema for such a set is unordered such that the disclosure of any element does not leak information about any other element. This requires a combination of an `anyOf` composition operator at the set level and `oneOf` composition operators for each element. Membership in the set can be verified against a set of SAIDs, one from each element. The salty-nonce effectively blinds the element's contents when only its SAID is disclosed. The `anyOf` composition operator is not order-dependent. This means that the selectively disclosable set can be provided as an ordered list of elements, yet one or more of its elements may be disclosed in any order so that the original order does not leak information.

- Bulk-issued instance disclosure relies on issuing multiple instances of a given ACDC, each a copy but with unique instance identifiers so that the disclosure of one instance is not correlatable to another via the instance identifiers. 

All the graduated disclosure mechanisms may be used in combination.

A salient difference between Partial disclosure and Selective disclosure of a given block is the degree to which information about other fields is exposed in order to make Full disclosure of its detailed field values. A partially disclosable block, when fully disclosed, exposes, at the very least, the labels of other fields in its enclosing block (a field map). Whereas a selectively disclosable block, when fully disclosed, does not expose any information about other yet-to-be-exposed fields, including their labels in its enclosing block (a field map array). 

To clarify, when used in the context of Selective disclosure, Full disclosure means detailed disclosure of the selectively disclosed attributes in the element's block, not detailed disclosure of all selectively disclosable attributes in all elements. Whereas when used in the context of Partial disclosure, Full disclosure means detailed disclosure of at least the labels of other fields in the enclosing field map (block) that was so far only partially disclosed. Full disclosure of a nested Partially disclosed block entails the Full disclosure of the fields in the branch that extends down to the nested block and at least the disclosure of the labels of all the fields in the enclosing blocks of that branch.

### Contractually protected disclosure

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/17
:::


Graduated disclosure enables a comprehensive protection mechanism called Contractually Protected Disclosure. There are two
contractually protected disclosure mechanisms as follows:

- Chain-link confidentiality disclosure
- Contingent disclosure

In a Contractually protected disclosure, the potential Discloser first makes an offer using the least (partial) disclosure of some information about other information to be disclosed (full disclosure) contingent on the potential Disclosee first agreeing to the contractual terms provided in the offer. The contractual terms could, for example, limit the disclosure to third parties of the yet to be disclosed information. But those contractual terms may also include provisions that protect against liability or other concerns, not merely disclosure to third parties. The process by which such least disclosures progress to full disclosure is described in the IPEX (Issuance and Exchange Protocol) section below.

One special case of a Contractually protected disclosure is a Chain-link confidential disclosure [[ref: CLC]]. Chain-link confidentiality imposes conditions and limitations on the further disclosure and/or use of the disclosed data. These may be specific terms of use or other consensual constraints. These terms may be applied to subsequent disclosures by the Disclosee that follow the data (hence chain-link). Another way of viewing Chain-link confidential disclosure is that the disclosed data has "strings attached." The chaining, in this case, is different from the chaining of ACDCs via their edges, i.e., a DAG of ACDCs. Chain-link confidentiality, in contrast, chains together a sequence of Disclosees. Each Disclosee in the sequence, in turn, is the Discloser to the next Disclosee. The terms-of-use of the original disclosure as applied to the original Disclosee shall be applied by each subsequent Discloser to each subsequent Disclosee via each of the subsequent disclosures.  These terms of use are meant to contractually protect the data rights of the original Issuer or Issuee of the data being disclosed. These terms of use typically constrain disclosure to only approved parties, i.e., imbue the chain of disclosures with some degree of confidentiality.

Another special case of Contractually protected disclosure is Contingent disclosure. In a Contingent disclosure, some contingency is specified in the rule section that places an obligation by some party to make a disclosure when the contingency is satisfied. This might be recourse given the breach of some other contract term. When that contingency is met, then the Contingent disclosure must be made by the party whose responsibility it is to satisfy that disclosure obligation. The responsible party may be the Discloser, or it may be some other party, such as an escrow agent. The Contingent disclosure clause may reference a cryptographic commitment to a private ACDC or private attribute ACDC (Partial disclosure) that satisfies via its Full disclosure the Contingent disclosure requirement. Contingent disclosure may be used to limit the actual disclosure of personally identifying information (PII) to a just-in-time, need-to-know basis (i.e., upon the contingency) and not a priori. As long as the Discloser and Disclosee trust the escrow agent and the verifiability of the commitment, there is no need to disclose PII about the Discloser in order to enable a transaction, but merely an agreement to the terms of the contingency. This enables something called latent accountability. Recourse via full disclosure of PII is latent in the Contingent disclosure but never realized (actualized) until the conditions of the contingency is satisfied. This minimizes inadvertent leakage while protecting both the Discloser and the Disclosee.


## Issuance and Presentation Exchange (IPEX)

The Issuance and Presentation Exchange (IPEX) Protocol provides a uniform mechanism for the issuance and presentation of ACDCs [[ref: ACDC]] in a securely attributable manner. A single protocol is able to work for both types of exchanges by recognizing
that all exchanges (both issuance and presentation) may be modeled as the disclosure of information by a Discloser to a Disclosee. The difference between exchange types is the information disclosed, not the mechanism for disclosure.
Furthermore, the chaining mechanism of ACDCs and support for both targeted and untargeted ACDCs provide sufficient variability to accommodate the differences in applications or use cases without requiring a difference in the exchange protocol itself. This greatly simplifies the exchange protocol. This simplification has two primary advantages. The first is enhanced security. A well-delimited protocol can be designed and analyzed to minimize and mitigate attack mechanisms.
The second is convenience. A standard, simple protocol is easier to implement, support, update, understand, and adopt. The tooling is more consistent.

This IPEX [[ref: IPEX]] protocol leverages important features of ACDCs and ancillary protocols such as CESR [[ref: CESR]], SAIDs [[ref: SAID]], and CESR-Path proofs [[ref: Proof-ID]] as well as Ricardian contracts [[ref: RC]] and graduated disclosure (metadata, partial, selective, full) to enable contractually protected disclosure. Contractually protected disclosure includes both chain-link confidential [[ref: CLC]] and contingent disclosure [[ref: ACDC]].


### Exchange Protocol

| Discloser | Disclosee | Initiate | Contents |  Description |
|:-:|:-:|:-:|:--|:--|
| | `apply`| Y | schema or its SAID, attribute field label list, signature on `apply` or its SAID | schema SAID is type of ACDC, optional label list for selective disclosure, CESR-Proof signature|
|`spurn`|  | N | |rejects `apply` |
|`offer`|  | Y | metadata ACDC or its SAID, signature on `offer` or its SAID  | includes schema or its SAID, other partial disclosures, selective disclosure label list, CESR-Proof signature |
| | `spurn` | N | |rejects `offer` |
| | `agree`| N | signature on `offer` or its SAID | CESR-Proof signature |
|`spurn`|  | N | |rejects `agree` |
|`grant`|  | Y | full or selective disclosure ACDC, signature on `grant` or its SAID  | includes attribute values, CESR-Proof signature |
|| `admit` | N | signature on `grant` or its SAID  | CESR-Proof signature |

#### Commitments via SAID

All the variants of an ACDC have various degrees of expansion of the compact variant. Therefore, an Issuer commitment via a signature (direct) or KEL anchored seal (indirect) to any variant of ACDC (metadata, compact, partial, nested partial, full, selective, etc)  makes a cryptographic commitment to the top-level section fields shared by all variants of that ACDC because the value of a top-level section field is either the SAD (self-addressed data) or the SAID (self-addressed identifier) of the SAD of the associated section. Both a SAD and its SAID, when signed or sealed, each provide a verifiable commitment to the SAD. In the former, the signature or seal verification is directly against the SAD itself. In the latter, the SAID as digest must first be verified against its SAD, and then the signature or seal on the SAID may be verified. This indirect verifiability (one or multiple levels of commitment via cryptographic digests) assumes that the cryptographic strength of the SAID digest is equivalent to the cryptographic strength of the signature used to sign it. To clarify, because all variants share the same top-level structure as the compact variant, then a signature on any variant may be used to verify the Issuer's commitment to any other variant either directly or indirectly, in whole or in part on a top-level section by top-level section basis. This cross-variant Issuer commitment verifiability is an essential property that supports graduated disclosure by the Disclosee of any or all variants, whether full, compact, metadata, partial, selective etc.

To elaborate, the SAID of a given variant is useful even when it is not the SAID of the variant the Issuer signed because, during graduated disclosure, the Discloser MAY choose to sign or seal that given variant to fulfill a given step in an IPEX graduated disclosure transaction. The Discloser thereby can make a verifiable disclosure in a given step of the SAD of a given variant that fulfills a commitment made in a prior step via its signature or seal on merely the SAID of the SAD of the variant so disclosed.

For example, the Metadata variant of an ACDC will have a different SAID than the Compact variant because some of the top-level field values may be empty in the Metadata variant. One can think of the Metadata variant as a partial manifest that only includes those top-level sections that the Discloser is committing to disclose in order to induce the Disclosee to agree to the contractual terms of use when disclosed. 

To elaborate, an IPEX transaction is between the Discloser and Disclosee, who both may make non-repudiable commitments to each other via signing or sealing variants of the ACDC to be disclosed. Typically, this means that the Discloser will eventually need to fulfill its commitment with proof of disclosure to the Disclosee. This proof may be satisfied either against the Discloser's signature or seal on the actual disclosed SAD or against the Discloser's signature or seal on the SAID of the actual disclosed SAD. In addition, the Disclosee will typically require proof of issuance via a non-repudiable signature or seal by the Issuer on a variant of the disclosed SAD that is verifiable (directly or indirectly) against the variant that is the disclosed SAD.

To summarize, when the Issuer commits to the composed schema of an ACDC it is committing to all the variants so composed. As described above, the top-level field values in the compact variant enable verification against disclosure of any of the other Issuer committed variants because they all share the same top-level structure. This applies even to the metadata variant in spite of it only providing values for some top-level sections and not others. The verifiablity of a top-level section is separable.

Consequently, the IPEX protocol must specify how a validator does validation of any variant in a graduated disclosure. To restate, there are two proofs that a Discloser must provide. The first is proof of issuance (PoI), and the second is proof of disclosure (PoD). In the former, the Discloser provides the variant via its SAD that was actually signed or seal (as SAD or SAID of SAD) by the Issuer in order for the Disclosee to verify authentic issuance via the signature on that variant.  In the latter, the Discloser must disclose the Issuer-enabled (via schema composition) variant that the Discloser offered to disclose as part of the graduated disclosure process.

#### IPEX Validation

The goal is to define a validation process (set of rules) that works for all variants of an ACDC and for all types of graduated disclosure of that ACDC.

For example, in the bulk issuance of an ACDC (see bulk issued ACDCs in the Annex), the Issuer only signs or seals the blinded SAID of the SAD, which is the Compact variant of the ACDC, not the SAD itself. This enables a Discloser to make a proof of inclusion of the ACDC in a bulk issuance set by unblinding the signature on the blinded SAID without leaking correlation to anything but the blinded SAID itself. To clarify, the Disclosee can verify the commitment to the SAID via set inclusion without disclosing any other information about the ACDC. Issuer signing or sealing of the SAID, not the SAD, also has the side benefit of minimizing the computation of large numbers of bulk-issued commitments.

##### Issuer Commitment Rules

The Issuer MUST provide a signature or seal on the SAID of the most compact form variant defined by the schema of the ACDC see the "most compact form" algorithm above. 

The different variants of an ACDC form a hash tree (using SAIDs).
A commitment to the top-level SAID of the compact version of the ACDC is equivalent to a commitment to the hash tree root (trunk). This makes a verifiable commitment to all expansions of that tree.
Different variants of an ACDC (SADs with SAIDs) correspond to different paths through the hash tree.
The process of verifying a nested block SAD against its SAID is essentially verifying proof of inclusion of the branch of the hash tree that includes that nested block. This allows a single commitment (signature or seal) to provide Proof of Issuance (PoI) of the presentation of any schema-authorized variants of the ACDC.

An Issuer MAY provide signatures or seals on the SAIDS of other variants, as well as signatures or seals on the SADs of other variants.

To summarize.

Proof of Issuance (PoI) is provided by disclosing the SAID of the most compact variant and the verifiable commitment (signature or seal) by the Issuer on that SAID.

Proof of Disclosure (PoD) is provided by disclosing the SAD of the most compact variant and then recursively disclosing (expanding) the nested SADs of each of the blocks of the most compact variant as needed for the promised disclosure.

Thus, for any disclosed variant of an ACDC, the Disclosee need only verify one Proof of Issuance (PoI) as defined above and may need to verify a specific Proof of Disclosure (PoD) for a given disclosed variant as defined above.


### Disclosure-specific (bespoke) issued ACDCs

Chaining two or more ACDCs via edges enables disclosure-specific issuance of bespoke issued ACDCs. A given Discloser of an ACDC issued by some Issuer may want to augment the disclosure with additional contractual obligations or additional information sourced by the Discloser where those augmentations are specific to a given context, such as a specific Disclosee. A given Discloser issues its own bespoke ACDC referencing some other ACDC via an Edge. This means that the normal validation logic and tooling for a chained ACDC can be applied without complicating the presentation exchange logic. Furthermore, attributes in other ACDCs pointed to by edges in the bespoke ACDC may be addressed by attributes in the bespoke ACDC using JSON Pointer or CESR-SAD-Path proof references that are relative to the node SAID in the edge [[ref: RFC6901]] [[ref: Proof_ID]].

For example, this approach enables the bespoke ACDC to identify (name) the Disclosee directly as the Issuee of the bespoke ACDC. This enables contractual legal language in the rule section of the bespoke ACDC that references the Issuee of that ACDC as a named party. Signing the agreement to the offer of that bespoke ACDC consummates a contract between the named Issuer and the named Issuee. This approach means that custom or bespoke presentations do not need additional complexity or extensions. Extensibility comes from reusing the tooling for issuing ACDCs to issue a bespoke or disclosure-specific ACDC. When the only purpose of the bespoke ACDC is to augment the contractual obligations associated with the disclosure, then the Attribute section, `a`, field value of the bespoke ACD may be empty, or it may include properties whose only purpose is to support the bespoke contractual language.

Similarly, this approach effectively enables a type of rich presentation or combined disclosure where multiple ACDCs may be referenced by edges in the bespoke ACDC that each contributes some attribute(s) to the effective set of attributes referenced in the bespoke ACDC. The bespoke ACDC enables the equivalent of a rich presentation without requiring any new tooling [[ref: Abuse]].

#### Example of a bespoke issued ACDC

Consider the following disclosure-specific ACDC. The Issuer is the Discloser, the Issuee is the Disclosee. The rule section includes a context-specific anti-assimilation clause that limits the use of the information to a single one-time usage purpose, in this case, admittance to a restaurant.  The ACDC includes an edge that references some other ACDC that may, for example, be a coupon or gift card. The attribute section includes the date and place of admittance.

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "s":  "EGGeIZ8a8FWS7a646jrVPTzlSkUPqs4reAXRZOkogZ2A",
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA",
    "date": "2022-08-22T17:50:09.988921+00:00",
    "place": "GoodFood Restaurant, 953 East Sheridan Ave, Cody WY 82414 USA"
  },
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "other":
    {
      "d": "E9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn",
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA"
    }
  },
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "Assimilation":
    {
      "d": "EXgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
      "l": "Issuee hereby explicitly and unambiguously agrees to NOT assimilate, aggregate, correlate, or otherwise use in combination with other information available to the Issuee, the information, in whole or in part, referenced by this container or any containers recursively referenced by the edge section, for any purpose other than that expressly permitted by the Purpose clause."
    },
    "Purpose":
    {
      "d": "EY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw",
      "l": "One-time admittance of Issuer by Issuee to eat at place on date as specified in Attribute section."
    }
  }
}
```




[//]: # (examples annex citation)

Informative examples of fully-featured variants of ACDCs can be found in Annex C.


## Transaction event logs (TELs) as ACDC state registries

### Overview

A Transaction Event Log (TEL) is a hash-chained data structure of sealed transaction events that can be used to track the transaction states (typically those associated with one or more ACDCs). Events in the  TEL are sealed (anchored) in a KEL using seals. A seal can be as simple as the event's SAID (cryptographic strength digest). A transaction event seal may also include the transaction event's sequence number to make it easier to look up and verify.  Because key events in a KEL are nonrepudiably signed by its controller, the appearance of a transaction event seal provides a verifiable non-repudiable commitment to the transaction event by the KEL controller. This makes TELs, which are thereby bound to KELs, also securely attributable to the KEL's controller.  This provides verifiable but decorrelatable extensibility to KEL semantics. Any number of transaction event types can be constructed for different applications that may be securely attributed without complicating KEL semantics. The seals need no semantics beyond their secure attributability to the AID of the KEL controller. The semantics of the transaction event's state may hidden by the transaction event SAID, which in turn may be protected from rainbow table attack by a cryptographic strength UUID in the transaction event. Therefore, the transaction state, as given by a sequence of transaction events, can be either public or private, depending on how the transaction events are structured. Similarly to ACDCs themselves, graduated disclosure mechanisms may be applied to transaction events. 

Importantly, the process of sealing transaction events in a KEL binds the key state at the sealing (anchoring) key event to the transaction state. This enables an extremely beneficial property of TELs; that is, the verifiability of transaction events in the TEL persists in spite of changes to key states in the sealing KEL. In other words, the verifiability of transaction events persists in spite of changes in the key state. To clarify, sealed transaction events remain verifiably bound to the key state at the point of issuance of the sealing event. An example of a transaction state that benefits from this property is a TEL that tracks the issuance and revocation state of dynamically revocable ACDCs, i.e., a revocation registry. 

The transaction events shall be sealed (anchored or bound) in a KEL using Transaction Event Seals, whose JSON representation is as follows.

```json
{
 "s": "3",
 "d": "ELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM"
}
```

The CESR representation of the seal couple is given by  the count code `-0##` or `-0O#####`


### Validating transaction events

As described above, a KEL can control a TEL by sealing (anchoring) transaction-specific events from the TEL inside key events in the KEL. 
The steps to this process are defined as follows:

1. Assign each TEL a universally unique identifier (such as the SAID of an associated ACDC)
2. Associate each TEL with the KEL's controller AID that seals the transaction events. This AID is the Issuer of the transaction event.
3. Create the transaction-specific event with an event SAID.
4. Generate a seal that includes the event SAID.
5. Include the seal of that transaction event in a key event in the controlling KEL.
6. Have the sealing key event accepted (appended) into its KEL by the KEL controller. This means at least signing the sealing key event and may include witnessing and or delegating the event. Such acceptance makes a verifiable, nonrepudiable commitment to the seal (digest) of the serialized transaction event.

Any validator can cryptographically verify the authoritative state of the transaction by validating the presence of the seal in the associated KEL.  The TEL events themselves do not have to be signed because the signed commitment to the event in the form of the digest in the seal in the KEL is cryptographically equivalent to signing the transaction event itself. Typically, the Validator is given a reference to the sealing event via a key event seal reference that includes the Issuer (KEL controller) AID, the key event's sequence number, and its SAID. The Issuer of the transaction event can either directly attach the seal reference to the ACDC or can provide an API where transaction events or their seal references and their KEL seal references can be looked up by the SAID of the ACDC associated with the transaction event. Given a key event seal reference for a given transaction event, a validator can then look up and verify the presence of the seal in the KEL.

### Verifiable Container/Credential Registry

ACDCs may be rightly generically referred to as Verifiable Containers (VCs). Often, ACDCs are used as entitlements or credentials and, therefore, may also be rightly referred to as Verifiable Credentials (VCs). The abbreviation VC works in either case. An ACDC can more simply be denoted as a Container or a Credential. A Verifiable Container/Credential Registry (VCR) is a type of TEL. It is a form of a Verifiable Data Registry (VDR) that tracks the state of ACDCs issued by the controller of the KEL. Without loss of specificity, in this section, a TEL serving the purpose of a VCR may be simply denoted as a Registry. A Registry that tracks the dynamic issuance revocation state of an ACDC is called a Revocation Registry.


### Blindable state registry

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/32
:::
#### Overview

In some applications, it is desirable that the current state of an ACDC be hidden or blinded such that the only way for a potential Validator of the state to observe that state is when the Controller of some AID, when acting as Discloser, discloses the state at the time of presentation of that ACDC. This makes the associated TEL a blindable state registry. This is a type of private registry. To clarify, the Issuer designates some AID as the Discloser. Typically, for ACDCs with an Issuee, the Discloser is the Issuee, but the Issuer could designate any AID as the Discloser. Only the Discloser can unblind the state to a potential Disclosee.

In a blindable state Registry, usually, disclosure of the state by Discloser to Disclosee is interactive. A Disclosee may only observe the state when first unblinded in an interactive exchange with the Discloser. After disclosure, the Discloser may then request that the Issuer update the state with a new blinding factor (the blind). The Disclosee cannot then observe the current state of the TEL without yet another disclosure interaction with the Discloser.

The blind is derived from a secret salt shared between the Issuer and the designated Discloser. The current blind is deterministically derived from this salt and the sequence number of the transaction event. This is used to blind the state of the event. To elaborate, the hierarchically deterministic derivation path for the blind is the sequence number of the TEL event, which, combined with the salt, produces a universally unique salty nonce (UUID) to act as the blind. The Issuer publishes the transaction event with a blinded state so that a Validator can independently verify the Issuer's commitment to that state but without being able to determine the state via a seal in the Issuer's KEL with the SAID of that event. Only the Issuer can change the actual blinded state. Only the Issuer and Discloser have a copy of the secret salt, so only they can independently derive the current blind from the sequence number. Given the blind and a small finite number of possible values for the transaction state, the Discloser can verifiably discover and hence unblind the current transaction state from the published SAID of the current transaction event, its sequence number, and the shared secret salt. 

The Issuer may provide an authenticated service endpoint for the Discloser to which the Discloser can make a signed request to update the blind.  Each new event published by the Issuer in the Registry shall increment the sequence number and hence the blinding factor but may or may not change the actual blinded state.  Because each updated event in the Registry has a new blinding factor regardless of an actual change of state or not, an observer cannot correlate state to event updates.

A blindabe state Registry may be used in an unblinded fashion. The issuer could just publish the state unblinded. This makes is a public Registry. Consequently, a blindable state Registry is generic. It may be used in either a private or public manner.

#### Message types

Blindable state registries have two types of events. These types are shown in the following table:

|Ilk| Name | Description|
|---|---|---|
|`rip`| Registry Inception | registry initialization |
|`upd`| Update | transaction event state update |

In some cases, the usage of the registry may provide correlatable information, as would be the case where the first real transaction state is always the same or the final state results in the disuse of the Registry. In those cases, the Issuer may choose to define an empty (null) state and an empty (null) ACDC SAID as known placeholder values. The first transaction state update event in the Registry can, therefore, be published before any real ACDC has been created, to which it may be later applied. Disuse of the registry can be hidden by continuing to update the blind to the state without changing the final state value for some time after the ACDC has been revoked or abandoned. 


#### Top-level fields

The reserved field labels for the top level of a blindable state registry transaction event are as follows:

|Label|Description|
|---|---|---|
|v| version string |
|t| message type |
|d| event block SAID |
|u| UUID salty nonce |
|i| Issuer AID |
|rd| Registry SAID|
|s| sequence number|
|p| prior event SAID |
|dt| issuer relative ISO date/time string |
|a| state attribute block or attibute block SAID|


#### Init event fields

The fields for the Init, `rip` event , given by their labels, shall appear in the following order, `[v, t, d, u, i, s, dt]`. All are required. The value of the message type, `t` field shall be `rip`. The value of the sequence number field, `s` shall be the hex encoded string for the integer 0. 

#### Update event fields

The fields for the Update, `upd` event , given by their labels, shall appear in the following order, `[v, t, d, rd, s, p, dt, a]`. All are required. The value of the message type, `t` field shall be `upd`. 

#### Field descriptions

##### Version string, `v` field

The version string, `v` field value uses the same format as an ACDC version string {{see above}}. The protocol type shall be `ACDC`.

##### Message type, `t` field

The message type, `t` field value shall be be one of the message types in the table above. The message types do not leak any state information. The first message in some types of registries such as an issuance revocation registry

##### SAID, `d` field

The SAID, `d` field value shall be the SAID of its enclosing block. A transaction event's SAID enables a verifiable globally unique reference to that event.

##### UUID, `u` field
The UUID, `u` field value shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. The UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's SAID and knowledge of all possible state values, cannot discover the actual state in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's structure, possible state values, and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's state unless and until there has been a disclosure of that state.

##### Issuer, `i` field

The Issuer, `i` field value shall be the AID of the Issuer. This removes any ambiguity about the semantics of a seal of a transaction event that appears in a KEL. When the KEL controller AID and Issuer AID are the same for a transaction event seal that appears in a given KEL, then the KEL controller is making a commitment as Issuer to the transaction event. A transaction event seal that appears in a KEL with a different controller AID is merely a nonrepudiable endorsement of the transaction state by some other party, not a duplicity-evident nonrepudiable commitment by the Issuer to the transaction state. This may appear to be redundant because the Issuer AID also appears in the ACDC. In a blinded state Registry, however, the ACDC SAID only appears in the blinded attribute block likewise in a yet-to-be-disclosed private ACDC, the Issuer is also blinded, so a Registry observer that hosts a copy of the Registry that is not also a Disclosee of either the expanded transaction event and/or the associated ADCD would not be able to confirm that commitment and may thereby be subject to a DDoS attack without the presence of the Issuer, `i` field in the Registy initialization event's public top-level fields.

##### Registry SAID, `rd` field

The Registry SAID, `rd` field value shall be the value of the SAID, `d` field of the Registry Inception, `rip` event. Because the Issuer, `i` field appears in the `rip` event, the Registry SAID, `rd` field value cryptographically binds the Registry to the Issuer AID. The Registry SAID enables a verifiable globally unique reference to the Registry (TEL). Update events shall include the Registry SAID, `rd` field so that they can be easily associated with the Registry (TEL). The ACDC managed by the Registry also includes a reference to the Registry SAID, `rd` field value, thereby binding the ACDC to the Registry. 

##### Sequence number, `s` field

The sequence number, `s` field value shall be a hex-encoded string with no leading zeros of a zero-based strictly monotonically increasing integer. The first (zeroth) transaction event in a given Registry (TEL) shall have a sequence number of 0 or `0` hex.

##### Prior event SAID, `p` field

The prior event SAID, `p` field value shall be the SAID, `d` field value of the immediately prior event in the TEL. The prior, `p` field backward chains together the events in a given TEL.

##### Datetime, `dt` field

The datetime, `dt` field value shall be the ISO-8601 datetime string with microseconds and UTC offset as per IETF RFC-3339. This shall be the datetime of the issuance of the transaction event relative to the clock of the issuer. An example datetime string in this format is as follows:

`2020-08-22T17:50:09.988921+00:00`

##### Attribute, `a` field

The attribute, `a` field value shall be the SAID of the blinded attribute block when used in a blinded (private) fashion. Alternatively, when used in an unblinded (public) fashion, the attribute, `a` field value shall be either the fully expanded attribute block (field map) or the SAID of the attribute block but without its UUID, `u` field. See below for a description of the expanded attribute block.

#### Expanded attribute block

The expanded attribute block has the following fields:

|Label|Description|
|---|---|---|
|d| attribute block SAID |
|u| UUID salty nonce blinding factor, random or HD generated |
|cd| container/credential SAID of ACDC or ACDC bulk aggregate when bulk-issued | 
|ts| transaction state value string | 

The fields shall appear in the following order `[d, u, cd, ts]`. When used in private (blinded) mode, all are required. When used in public (unblinded) mode, the SAID, `d` field is optional, the UUID, `u` field is not allowed, but both the container SAID, `cd` and transaction state, `ts` fields are required.

##### SAID, `d` field

The SAID, `d` field value shall be the SAID of its enclosing block. An attribute section's SAID enables a verifiable globally unique reference to that state contined in the block but without necessarily disclosing that state.

##### UUID, `u` field

The UUID, `u` field value shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. The UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[ref: Hash]]. An adversary, when given both the block's SAID and knowledge of all possible state values, cannot discover the actual state in a computationally feasible manner, such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's structure, possible state values, and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's state unless and until there has been a disclosure of that state.

When the UUID, `u`, is derived from a shared secret salt and a public path such as the sequence number using a hierarchically deterministic derivation algorithm, and given that the possible state values are finite small, then any holder of the shared secret can derive the state given the public information in the top-level fields of the transaction event.

##### Container SAID, `cd` field

The container SAID, `cd` field value shall be the SAID of the associated ACDC or the SAID of the bulk aggregate of a bulk-issued set of ACDCs (whichever applies). The container SAID, `cd` field value binds an ACDC or bulk-issued set of ACDCs to the Registry state.  

##### Transaction state, `ts` field

The transaction state, `ts` field value shall be a string from a small finite set of strings that delimit the possible values of the transaction state for the Registry. For example, the state values for an issuance/revocation registry may be `issued` or `revoked`.


#### Private (blinded) state registry example

Consider a blindable state revocation registry for ACDCs operated in blinded (private) mode. The transaction state can be one of two values, `issued`, or `revoked`. In this case, placeholder values of the empty, `` string for transaction state, `ts` and container SAID, `cd` fields are also employed to decorrelate the initialization.  The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```

Given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere as the registry SAID, `rd` field. The `rd` field value is derived from the Issuer AID, binding the Registry to the Issuer AID.

The state is initialized with decorrelated placeholder values with the issuance of the following placeholder update event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```

The associated expanded attribute block is as follows:

```json
{
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "u": "ZHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "cd": "",
 "ts": ""
}
```
Notice that the value of the attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded attribute block. In this case, the value of the container SAID, `cd` field, and transaction state, `ts` fields are just empty strings as placeholder values. The transaction state does not yet correspond to a real ACDC.  The blind for this placeholder attribute block may be updated any number of times prior to its first use as the true state of a real ACDC. This makes the first use(s) of the registry uncorrelated to the actual issuance of the real ACDC. 

Suppose that the Discloser has been given the shared secret salt from which the value of the blind, UUID, `u` field was generated. The Discloser can then download the published transaction event to get the sequence number, `s` field value. With that value and the shared secret salt, the Discloser can regenerate the blind UUID, `u` field value. The discloser also knows the real ACDC that will be used for this Registry. Consequently, it knows that the value of the ACDC, SAID, `d` field must be either the empty string placeholder or the real ACDC SAID. The Discloser can now compute the SAID, `d` field value of the expanded attribute block for either the empty placeholder values of `cd` and `ts` fields or with the real ACDC SAID for the `cd` field and one of the two possible state values, namely, `issued` or `revoked` for the `ts` field. This gives three possibilities. The Discloser tries each one until it finds the one that matches the published transaction event attribute, `a` field value. The Discloser can then verify if the published value is still a placeholder or the real initial state.

Sometime later, the real ACDC is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the registry SAID, `rd` field of that ACDC will be the registry SAID given by the value of the SAID, `d` field in the registry inception, `rip` event. This binds the ACDC to the Registry.

Suppose the associated Update event occurs at sequence number 5. The published transaction event is as follows:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "5",
 "p": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```

The associated expanded attribute block is as follows: 

```json
{
 "d": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-",
 "u": "ZIZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PL",
 "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
 "ts": "issued"
}
```

Notice that the value of the attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded attribute block. Notice further that in this case, the value of the container SAID, `cd` field is the real value of the ACDC, and the value of the transaction state, `ts` field is `issued` (not placeholder).  Suppose that the Discloser has been given the shared secret salt from which the value of the blind, UUID, `u` field was generated. The Discloser can then download the published transaction event to get the sequence number, `s` field value. With that value and the shared secret salt, the Discloser can regenerate the blind UUID, `u` field value. The discloser also knows which ACDC it wishes to disclose so it also has the ACDC, SAID, `d` field value. The Discloser can now compute the SAID, `d` field value of the expanded attribute block for either the empty placeholder values of `cd` and `ts` fields or with the real ACDC SAID for the `cd` field and one of the two possible state values, namely, `issued` or `revoked` for the `ts` field. This gives three possibilities. The Discloser tries each one until it finds the one that matches the published transaction event attribute, `a` field value. The Discloser can then disclose the matching expanded attribute block to the Disclosee, who can verify it against the published transaction event.

The Discloser can then instruct the Issuer to issue one or more updates with new blinding factors so that the initial Disclosee may no longer validate the state of the ACDC without another interactive disclosure by the Discloser.

Suppose at some later time, a validator requires that the Discloser provide continuing proof of issuance. In that case, the Discloser would disclose the current state of the Registry. Suppose it has been revoked. The Discloser may either refuse to disclose (with the associated consequences) or may only verifiably disclose the true state. Suppose this is at sequence number 9 as follows:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "9",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI"
}
```

The associated expanded attribute block is as follows: 

```json
{
 "d": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI",
 "u": "ZNoRxCJp2wIGM9u2Edk-PLIZ1H4zpq06UecHwzy-K9Fp",
 "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
 "ts": "revoked"
}
```

The Discloser could continue to have the blind updated periodically. This would generate new transaction events with new values for its attribute, `a` field, but without changing the transaction state field value. This decorrelates the time of revocation with respect to the latest event in the Registry.

#### Public (unblinded) state registry example 

Consider a blindable state revocation registry for ACDCs operated in an unblinded (public) mode. The transaction state can be one of two values, `issued`, or `revoked`. The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```

Given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere as the registry SAID, `rd` field. The `rd` field value is derived from the Issuer AID, binding the Registry to the Issuer AID. 

Sometime later, an ACDC is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the registry SAID, `rd` field of that ACDC will be the registry SAID given by the value of the SAID, `d` field in the registry inception, `rip` event. This binds the ACDC to the Registry.

The state is initialized with the following update event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": "EK9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-"
}
```

The associated expanded attribute block is as follows:

```json
{
 "d": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
 "ts": "issued"
}
```
Notice that the value of the attribute, `a` field in the transaction event, matches the value of the SAID, `d` field in the expanded attribute block. Further notice that the UUID, `u` field is missing. This makes the attribute block unblinded. The Issuer may provide an API that allows a Validator to query the attributed block for any given transaction event in the registry, or knowing that its unblinded, a Validator can try the two different state value possibilities to discover which one generates a SAID, `d` field value that matches the attribute, `a` field value in the event.


Sometime later with the ACDC is revoked with the publication by the Issuer of the following event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "2",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI"
}
```

The associated expanded attribute block is as follows: 

```json
{
 "d": "EGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wI",
 "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
 "ts": "revoked"
}
```

#### Simple public (unblinded) state registry example 

Consider a blindable state revocation registry for ACDCs operated in an unblinded (public) mode. The transaction state can be one of two values, `issued`, or `revoked`. The Issuer with AID, `ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx` first creates one among many placeholder Registries by issuing the following transaction event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "rip",
 "d": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "u": "0AHcgNghkDaG7OY1wjaDAE0q",
 "i": "ECJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRx",
 "s": "0",
 "dt": "2024-05-27T19:16:50.750302+00:00"
}
```

Given that the UUID, `u` field value has sufficient cryptographic entropy, the SAID, `d` field provides a universally unique identifier for the Registry that can be referenced elsewhere as the registry SAID, `rd` field. The `rd` field value is derived from the Issuer AID, binding the Registry to the Issuer AID. 

Sometime later, an ACDC for this registry is issued as indicated by its SAID, `d` field value, `ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P`. The value of the Issuer, `i` field of that ACDC will be the Issuer AID. The value of the registry SAID, `rd` field of that ACDC will be the registry SAID given by the value of the SAID, `d` field in the registry inception, `rip` event. This binds the ACDC to the Registry.

The state is initialized with the following simple update event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJp2w",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "1",
 "p": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "dt": "2024-06-01T05:01:42.660407+00:00",
 "a": 
 {
   "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
   "ts": "issued"
  }
}
```

Notice that the value of the attribute, `a` field in the transaction event, is now a field map block, not a SAID string. Further notice that both the SAID, `d`, and UUID, `u` fields are missing as they are now superfluous.

Sometime later, the ACDC is revoked with the publication by the Issuer of the following simple update event:

```json
{
 "v": "ACDCCAAJSONAACQ_",
 "t": "upd",
 "d": "EB2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9FpNoRxCJ",
 "rd": "ENoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06UecHwzy-K9Fp",
 "s": "2",
 "p": "EHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4zpq06Uec",
 "dt": "2024-07-04T05:01:42.660407+00:00",
 "a": 
 {
   "cd": "ELMZ1H4zpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-P",
   "ts": "revoked"
 }
}
```


### Transfer Registry

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/34
:::

## Annex

### Performance and Scalability

The compact disclosure and distribute property graph fragment mechanisms in ACDC can be leveraged to enable high performance at scale. Simply using SAIDs and signed SAIDs of ACDCs in whole or in part enables compact but securely attributed and verifiable references to ACDCs to be employed anywhere performance is an issue. Only the SAID and its signature need be transmitted to verify secure attribution of the data represented by the SAID. Later receipt of the data may be verified against the SAID. The signature does not need to be re-verified because a signature on a SAID is making a unique (to within the cryptographic strength of the SAID) commitment to the data represented by the SAID. The actual detailed ACDC in whole or in part may then be cached or provided on-demand or just-in-time.

Hierarchical decomposition of data into a distributed verifiable property graph, where each ACDC is a distributed graph fragment, enables performant reuse of data or more compactly performant reuse of SAIDs and their signatures. The metadata and attribute sections of each ACDC provide a node in the graph and the edge section of each ACDC provides the edges to that node. Higher-up nodes in the graph with many lower-level nodes need only be transmitted, verified, and cached once per every node or leaf in the branch not redundantly re-transmitted and re-verified for each node or leaf as is the case for document-based verifiable credentials where the whole equivalent of the branched (graph) structure must be contained in one document. This truly enables the bow-tie model popularized by Ricardian contracts, not merely for contracts, but for all data authenticated, authorized, referenced, or conveyed by ACDCs.

[//]: # (Cryptographic Strength and Security {#sec:annexB .informative})

### Cryptographic Strength and Security

#### Cryptographic Strength

For crypto-systems with perfect-security, the critical design parameter is the number of bits of entropy needed to resist any practical brute force attack. In other words, when a large random or pseudo-random number from a cryptographic strength pseudo-random number generator (CSPRNG) [[ref: CSPRNG]] expressed as a string of characters is used as a seed or private key to a cryptosystem with perfect-security, the critical design parameter is determined by the amount of random entropy in that string needed to withstand a brute force attack. Any subsequent cryptographic operations must preserve that minimum level of cryptographic strength. In information theory, [[ref: IThry]] [[ref: ITPS]] the entropy of a message or string of characters is measured in bits. Another way of saying this is that the degree of randomness of a string of characters can be measured by the number of bits of entropy in that string.  Assuming conventional non-quantum computers, the conventional wisdom is that, for systems with information-theoretic or perfect-security, the seed/key needs to have on the order of 128 bits (16 bytes, 32 hex characters) of entropy to practically withstand any brute force attack. A cryptographic quality random or pseudo-random number expressed as a string of characters will have essentially as many bits of entropy as the number of bits in the number. For other crypto systems such as digital signatures that do not have perfect-security, the size of the seed/key may need to be much larger than 128 bits in order to maintain 128 bits of cryptographic strength.

An N-bit long base-2 random number has 2<sup>N</sup> different possible values. Given that no other information is available to an attacker with Perfect security, the attacker may need to try every possible value before finding the correct one. Thus, the number of attempts that the attacker would have to try maybe as much as 2<sup>N-1</sup>.  Given available computing power, one can show easily that 128 is a large enough N to make brute force attack computationally infeasible.

Suppose that the adversary has access to supercomputers. Current supercomputers can perform on the order of one quadrillion operations per second. Individual CPU cores can only perform about 4 billion operations per second, but a supercomputer will parallelly employ many cores. A quadrillion is approximately 2<sup>50</sup> = 1,125,899,906,842,624. Suppose somehow an adversary had control over one million (2<sup>20</sup> = 1,048,576) supercomputers which could be employed in parallel when mounting a brute force attack. The adversary could then try 2<sup>50</sup> * 2<sup>20</sup> = 2<sup>70</sup> values per second (assuming very conservatively that each try only took one operation).

There are about 3600 * 24 * 365 = 313,536,000 = 2<sup>log<sub>2</sub>313536000</sup>=2<sup>24.91</sup> ~= 2<sup>25</sup> seconds in a year. Thus, this set of a million super computers could try 2<sup>50+20+25</sup> = 2<sup>95</sup> values per year. For a 128-bit random number this means that the adversary would need on the order of 2<sup>128-95</sup> = 2<sup>33</sup> = 8,589,934,592 years to find the right value. This assumes that the value of breaking the cryptosystem is worth the expense of that much computing power. Consequently, a cryptosystem with perfect-security and 128 bits of cryptographic strength is computationally infeasible to break via brute force attack.

#### Information theoretic Security and perfect-security

The highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key) is called  information theoretic security[[ref: ITPS]]. A cryptosystem that has this level of security cannot be broken algorithmically even if the adversary has nearly unlimited computing power including quantum computing. The system must be broken by brute force if at all. Brute force means that in order to guarantee success, the adversary must search for every combination of key or seed. A special case of information-theoretic security is called *perfect-security* [[ref: ITPS]].  Perfect-security means that the ciphertext provides no information about the key. There are two well-known cryptosystems that exhibit *perfect-security. The first is a One-time-pad (OTP) or Vernum Cipher [[ref: OTP]] [[ref: VCphr]], and the other is Secret splitting [[ref: SSplt]], a type of secret sharing [[ref: SShr]] that uses the same technique as an OTP.


[//]: # (# Examples {#sec:annexC .informative} )

### Selective disclosure

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/21
:::

As explained previously in section 5, the primary difference between Partial disclosure and Selective disclosure is determined by the correlatability with respect to its encompassing block after Full disclosure of the detailed field value. A partially disclosable field becomes correlatable to its encompassing block after its Full disclosure. Whereas a selectively disclosable field may be excluded from the Full disclosure of any other selectively disclosable fields in its encompassing block. After Selective disclosure, the selectively disclosed fields are not correlatable to the so far undisclosed but selectively disclosable fields in the same encompassing block. In this sense, Full disclosure means detailed disclosure of the selectively disclosed attributes not detailed disclosure of all selectively disclosable attributes.

Recall that Partial disclosure is an essential mechanism needed to support Chain-link confidentiality [[ref: CLC]]. The Chain-link confidentiality exchange offer requires partial disclosure, and full disclosure only happens after acceptance of the offer. Selective disclosure, on the other hand, is an essential mechanism needed to unbundle in a correlation minimizing way a single commitment by an Issuer to a bundle of fields (i.e., a nested block or array of fields). This allows separating a "stew" of "ingredients" (attributes) into its constituent ingredients (attributes) without correlating the constituents via the stew.

ACDCs, inherently benefit from a minimally sufficient approach to Selective disclosure that is simple enough to be universally implementable and adoptable. This does not preclude support for other more sophisticated but optional approaches. But the minimally sufficient approach should be universal so that at least one Selective disclosure mechanism be made available in all ACDC implementations. To clarify, not all instances of an ACDC must employ the minimal Selective disclosure mechanisms as described herein but all ACDC implementations must support any instance of an ACDC that employs the minimal Selective disclosure mechanisms as described above.

#### Tiered selective disclosure mechanisms

The ACDC chaining mechanism reduces the need for Selective disclosure in some applications. Many non-ACDC verifiable credentials provide bundled credentials because there is no other way to associate the attributes in the bundle of credentials. These bundled credentials could be refactored into a graph of ACDCs. Each of which is separately disclosable and verifiable thereby obviating the need for Selective disclosure.

Nonetheless, some applications require bundled attributes and therefore may benefit from the independent Selective disclosure of bundled attributes. This is provided by selectively disclosable attribute ACDCs.

The use of a revocation registry is an example of a type of bundling, not of attributes in a credential, but uses of a credential in different contexts. Unbundling the usage contexts may be beneficial. This is provided by bulk-issued ACDCs.

Finally, in the case where the correlation of activity of an Issuee across contexts even when the ACDC used in those contexts is not correlatable may be addressed of a variant of bulk-issued ACDCs that have unique Issuee AIDs with an independent Transaction event log (TEL) registry per Issuee instance. This provides non-repudiable (recourse supporting) disclosure while protecting from the malicious correlation between Second-parties and other Second- and/or Third-parties as to who (Issuee) is involved in a presentation.

#### Basic selective disclosure mechanism

The basic Selective disclosure mechanism shared by all is comprised of a single aggregated blinded commitment to a list of blinded commitments to undisclosed values. Membership of any blinded commitment to a value in the list of aggregated blinded commitments may be proven without leaking (disclosing) the unblinded value belonging to any other blinded commitment in the list. This enables provable Selective disclosure of the unblinded values. When a non-repudiable digital signature is created on the aggregated blinded commitment then any disclosure of a given value belonging to a given blinded commitment in the list is also non-repudiable. This approach does not require any more complex cryptography than digests and digital signatures. This satisfies the design ethos of minimally sufficient means. The primary drawback of this approach is verbosity. It trades ease and simplicity and adoptability of implementation for size. Its verbosity may be mitigated by replacing the list of blinded commitments with a Merkle tree of those commitments where the Merkle tree root becomes the aggregated blinded commitment.

Given sufficient cryptographic entropy of the blinding factors, collision resistance of the digests, and unforgeability of the digital signatures, either inclusion proof format (list or Merkle tree digest) prevents a potential Disclosee or adversary from discovering in a computationally feasible way the values of any undisclosed blinded value details from the combination of the schema of those value details and either the aggregated blinded commitment and/or the list of aggregated blinded commitments [[ref: Hash]] [[ref: HCR]] [[ref: QCHC]] [[ref: Mrkl]] [[ref: TwoPI]] [[ref: MTSec]]. A potential Disclosee or adversary would also need both the blinding factor and the actual value details.

Selective disclosure in combination with Partial disclosure for Chain-link confidentiality provides comprehensive correlation minimization because a Discloser may use a non-disclosing metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain-link confidentiality expressed in the rule section [[ref: CLC]]. Thus, only malicious Disclosees who violate Chain-link confidentiality may correlate between independent disclosures of the value details of distinct members in the list of aggregated blinded commitments. Nonetheless, they are not able to discover any as-of-yet undisclosed (unblinded) value details.

#### Selectively disclosable attribute ACDC

In a selectively disclosable attribute ACDC, the set of attributes is provided as an array of blinded blocks. Each attribute in the set has its own dedicated blinded block. Each block has its own SAID, `d`, field and UUID, `u`, field in addition to its attribute field or fields. When an attribute block has more than one attribute field, then the set of fields in that block are not independently selectively disclosable but must be disclosed together as a set. Notable is that the field labels of the selectively disclosable attributes are also blinded because they only appear within the blinded block. This prevents unpermissioned correlation via contextualized variants of a field label that appear in a selectively disclosable block. For example, localized or internationalized variants where each variant's field label(s) each use a different language or some other context correlatable information in the field labels themselves.

A selectively disclosable attribute section appears at the top level using the field label `A`. This is distinct from the field label `a` for a non-selectively-disclosable attribute section. This makes clear (unambiguous) the semantics of the attribute section's associated schema. This also clearly reflects the fact that the value of a compact variant of selectively disclosable attribute section is an aggregate, not a SAID. As described previously, the top-level selectively disclosable attribute aggregate section, `A`, field value is an aggregate of cryptographic commitments used to make a commitment to a set (bundle) of selectively disclosable attributes. The derivation of its value depends on the type of Selective disclosure mechanism employed. For example, the aggregate value could be the cryptographic digest of the concatenation of an ordered set of cryptographic digests, a Merkle tree root digest of an ordered set of cryptographic digests, or a cryptographic accumulator.

The Issuee attribute block is absent from an uncompacted untargeted selectively disclosable ACDC as follows:

```json
{
  "A":
  [
    {
      "d": "ELIr9Bf7V_NHwY1lkgveY4-Frn9y2PY9XgOcLxUderzw",
      "u": "0AG7OY1wjaDAE0qHcgNghkDa",
      "score": 96
    },
    {
      "d": "E9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PYgveY4-",
      "u": "0AghkDaG7OY1wjaDAE0qHcgN",
      "name": "Jane Doe"
    }
  ]
}
```

The Issuee attribute block is present in an uncompacted targeted selectively disclosable ACDC as follows:

```json
{
  "A":
  [
    {
      "d": "ErzwLIr9Bf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUde",
      "u": "0AqHcgNghkDaG7OY1wjaDAE0",
      "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA"
    },
    {
      "d": "ELIr9Bf7V_NHwY1lkgveY4-Frn9y2PY9XgOcLxUderzw",
      "u": "0AG7OY1wjaDAE0qHcgNghkDa",
      "score": 96
    },
    {
      "d": "E9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PYgveY4-",
      "u": "0AghkDaG7OY1wjaDAE0qHcgN",
      "name": "Jane Doe"
    }
  ]
}
```

##### Blinded attribute array

Given that each attribute block's UUID, `u`, field has sufficient cryptographic entropy, then each attribute block's SAID, `d`, field provides a secure cryptographic digest of its contents that effectively blinds the attribute value from discovery given only its Schema and SAID. To clarify, the adversary despite being given both the schema of the attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the attribute block in a computationally feasible manner such as a rainbow table attack [[ref: RB]] [[ref: DRB]].  Therefore, the UUID, `u`, field of each attribute block enables the associated SAID, `d`, field to securely blind the block's contents notwithstanding knowledge of the block's schema and that SAID, `d`, field.  Moreover, a cryptographic commitment to that SAID, `d`, field does not provide a fixed point of correlation to the associated attribute (SAD) field values themselves unless and until there has been specific disclosure of those field values themselves.

Given a total of ‘N’ elements in the attributes array, let a<sub>i</sub> represent the SAID, `d`, field of the attribute at zero-based index ‘’'. More precisely, the set of attributes is expressed as the ordered set,

\{a<sub>i</sub> for all i in \{0, ..., N-1\}\}.

The ordered set of a<sub>i</sub> may be also expressed as a list, that is,

\[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].

#### Composed Schema for selectively disclosable attribute section

Because the selectively disclosable attributes are provided by an array (list), the uncompacted variant in the schema uses an array of items and the `anyOf` composition Operator to allow one or more of the items to be disclosed without requiring all to be disclosed. Thus, both the `oneOf` and `anyOf` composition Operators are used. The `oneOf` is used to provide compact Partial disclosure of the aggregate, ‘A’, as the value of the top-level selectively disclosable attribute section, `A`, field in its compact variant and the nested `anyOf` operator is used to enable Selective disclosure in the uncompacted selectively disclosable variant.

```json
{
  "A":
  {
    "description": "selectively disclosable attribute aggregate section",
    "oneOf":
    [
      {
        "description": "attribute aggregate",
        "type": "string"
      },
      {
        "description": "selectively disclosable attribute details",
        "type": "array",
        "uniqueItems": true,
        "items":
        {
          "anyOf":
          [
            {
              "description": "issuer attribute",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "i"
              ],
              "properties":
              {
                "d":
                {
                  "description": "attribute SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "attribute UUID",
                  "type": "string"
                },
                "i":
                {
                  "description": "issuer SAID",
                  "type": "string"
                }
              },
              "additionalProperties": false
            },
            {
              "description": "score attribute",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "score"
              ],
              "properties":
              {
                "d":
                {
                  "description": "attribute SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "attribute UUID",
                  "type": "string"
                },
                "score":
                {
                  "description": "score value",
                  "type": "integer"
                }
              },
              "additionalProperties": false
            },
            {
              "description": "name attribute",
              "type": "object",
              "required":
              [
                "d",
                "u",
                "name"
              ],
              "properties":
              {
                "d":
                {
                  "description": "attribute SAID",
                  "type": "string"
                },
                "u":
                {
                  "description": "attribute UUID",
                  "type": "string"
                },
                "name":
                {
                  "description": "name value",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          ]
        }
      }
    ],
    "additionalProperties": false
  }
}
```

#### Inclusion proof via aggregated list digest

All the a<sub>i</sub> in the list are aggregated into a single aggregate digest denoted ‘A’ by computing the digest of their ordered concatenation. This is expressed as follows:

A = H(C(a<sub>i</sub> for all i in \{0, ..., N-1\})), where ‘H’ is the digest (hash) Operator and ‘C’ is the concatentation Operator.

To be explicit, using the targeted example above, let a<sub>0</sub> denote the SAID of the Issuee attribute, a<sub>1</sub> denote the SAID of the score attribute, and a<sub>2</sub> denote the SAID of the name attribute then the aggregated digest ‘A’ is computed as follows:

A = H(C(a<sub>0</sub>, a<sub>1</sub>, a<sub>2</sub>)).

Equivalently using ‘+’ as the infix concatenation operator, the aggregated digest is ‘A’ is computed as follows:

A = H(a<sub>0</sub> + a<sub>1</sub> + a<sub>2</sub>).

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [[ref: BDC][[ref: BDay][[ref: QCHC][[ref: HCR][[ref: Hash]].

In compact form, the value of the selectively disclosable top-level Attribute section, `A`, field is set to the aggregated value ‘A’. This aggregate ‘A’ makes a blinded cryptographic commitment to the all the ordered elements in the list,

\[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].

Moreover, because each a<sub>i</sub> element also makes a blinded commitment to its block's (SAD) attribute value(s), disclosure of any given a<sub>i</sub> element does not expose or disclose any discoverable information detail about either its own or another block's attribute value(s). Therefore, one may safely disclose the full list of a<sub>i</sub> elements without exposing the blinded block attribute values.

Proof of inclusion in the list consists of checking the list for a matching value. A computationally efficient way to do this is to create a hash table or B-tree of the list and then check for inclusion via lookup in the hash table or B-tree.

To protect against later forgery given a later compromise of the signing keys of the Issuer, the Issuer must anchor an issuance proof digest seal to the ACDC in its Key event log (KEL). This seal binds the signing Key state to the issuance. There are two cases. In the first case, an issuance/revocation registry is used. In the second case, an issuance/revocation registry is not used.

When the ACDC is registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the issuance (Inception) event in the ACDC's TEL entry. The issuance event in the TEL includes the SAID of the ACDC. This binds the ACDC to the issuance proof seal in the Issuer's KEL through the TEL entry.

When the ACDC is not registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the ACDC itself.

In either case, this issuance proof seal makes a verifiable binding between the issuance of the ACDC and the Key state of the Issuer at the time of issuance. Because aggregated value ‘A’ provided as the Attribute section, `A`, field, value is bound to the SAID of the ACDC which is also bound to the Key state via the issuance proof seal, the attribute details of each attribute block are also bound to the Key state.

The requirement of an anchored issuance proof seal means that the forger must first successfully publish in the KEL of the Issuer an inclusion proof digest seal bound to a forged ACDC. This makes any forgery attempt detectable. To elaborate, the only way to successfully publish such a seal is in a subsequent Interaction event in a KEL that has not yet changed its Key state via a Rotation event. Whereas any KEL that has changed its Key state via a Rotation must be forked before the Rotation. This makes the forgery attempt either both detectable and recoverable via Rotation in any KEL that has not yet changed its Key state or detectable as Duplicity in any KEL that has changed its Key state. In any event, the issuance proof seal ensures detectability of any later attempt at forgery using compromised keys.

Given that aggregate value ‘A’ appears as the compact value of the top-level Attribute section, `A`, field, the Selective disclosure of the attribute at index ‘j’ may be proven to the Disclosee with four items of information. These are:

- The actual detailed disclosed attribute block itself (at index ‘j’) with all its fields.
- The list of all attribute block digests, \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\] that includes a<sub>j</sub>.
- The ACDC in compact form with selectively disclosable Attribute section, `A`, field value set to aggregate ‘A’.
- The signature(s), ‘s’, of the Issuee on the ACDC's top-level SAID, `d`, field.

The actual detailed disclosed attribute block is only disclosed after the Disclosee has agreed to the terms of the rules section. Therefore, in the event the potential Disclosee declines to accept the terms of disclosure, then a presentation of the compact version of the ACDC and/or the list of attribute digests, \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\]. does not provide any point of correlation to any of the attribute values themselves. The attributes of block ‘j’ are hidden by a<sub>j</sub>\ and the list of attribute digests \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\] is hidden by the aggregate ‘A’. The Partial disclosure needed to enable Chain-link confidentiality does not leak any of the selectively disclosable details.

The Disclosee may then verify the disclosure by:
- computing a<sub>j</sub> on the selectively disclosed attribute block details.
- confirming that the computed a<sub>j</sub> appears in the provided list \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].
- computing ‘A’ from the provided list \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].
- confirming that the computed ‘A’ matches the value, ‘A’, of the selectively disclosable Attribute section, `A`, field value in the provided ACDC.
- computing the top-level SAID, `d`, field of the provided ACDC.
- confirming the presence of the issuance seal digest in the Issuer's KEL
- confirming that the issuance seal digest in the Issuer's KEL is bound to the ACDC top-level SAID, `d`, field either directly or indirectly through a TEL registry entry.
verifying the provided signature(s) of the Issuee on the provided top-level SAID, `d` field value.

The last 3 steps that culminate with verifying the signature(s) require determining the Key state of the Issuer at the time of issuance.  Therefore, this may require additional verification steps as per the KERI, PTEL, and CESR-Proof protocols.

A private selectively disclosable ACDC provides significant correlation minimization because a Discloser may use a metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain-link confidentiality expressed in the rule section [[ref: CLC]]. Thus, only malicious Disclosees who violate Chain-link confidentiality may correlate between presentations of a given private selectively disclosable ACDC. Nonetheless, the malicious Disclosees are not able to discover any undisclosed attributes.

#### Inclusion proof via Merkle tree root digest

The inclusion proof via aggregated list may be somewhat verbose when there are a large number of attribute blocks in the selectively disclosable Attribute section. A more efficient approach is to create a Merkle tree of the attribute block digests and let the aggregate, ‘A’, be the Merkle tree root digest [[ref: Mrkl]. Specifically, set the value of the top-level selectively disclosable attribute section, `A`, field to the aggregate, ‘A’ whose value is the Merkle tree root digest [[ref: Mrkl].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [[ref: TwoPI][[ref: MTSec]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, a<sub>j</sub> contributed to the Merkle tree root digest, ‘A. For ACDCs with a small number of attributes, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Hierarchical derivation at issuance of selectively disclosable attribute ACDCs

The amount of data transferred between the Issuer and Issuee (or recipient in the case of an Untargeted ACDC) at issuance of a selectively disclosable attribute ACDC may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUDI, `u`, fields from a shared secret salt [[ref: Salt].

There are several ways that the Issuer may securely share that secret salt. Given that an Ed25519 key pair(s) controls each of the Issuer and Issuee AIDs, (or recipient AID in the case of an Untargeted ACDC), a corresponding X15519 asymmetric encryption Key pair(s) may be derived from each controlling Ed25519 key pair(s) [[ref: EdSC][[ref: PSEd][[ref: TMEd][[ref: SKEM]. An X25519 public key may be derived securely from an Ed25519 public key [[ref: KeyEx][[ref: SKEM]. Likewise, an X25519 private key may be derived securely from an Ed25519 private key [[ref: KeyEx][[ref: SKEM].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [[ref: KeyEx][[ref: DHKE]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used has high entropy cryptographic material from which the secret salt may be derived.

In a non-interactive approach, the Issuer derives an X25519 asymmetric public encryption key from the Issuee's (recipient's) public Ed25519 public key. The Issuer then encrypts the secret salt with that public asymmetric encryption key and signs the encryption with the Issuer's private Ed25519 signing key. This is transmitted to the Issuee, who verifies the signature and decrypts the secret salt using the private X25519 decryption key derived from the Issuee's private Ed25519 key. This non-interactive approach is more scalable for AIDs that are controlled with a multi-sig group of signing keys. The Issuer can broadcast to all members of the Issuee's (or recipient's) multi-sig signing group individually asymmetrically encrypted and signed copies of then may be derived. Likewise, both compact and uncompacted versions of the ACDC then may be generated. The derivation path for the top-level UUID, `u`, field (for private ACDCS), is the string "0" and derivation path the zeroth indexed attribute in the attributes array is the string ‘0/0’. Likewise, the next attribute's derivation path is the string ‘0/1’ and so forth.

In addition to the shared salt and ACDC template, the Issuer also provides its signature(s) on its own generated Compact version ACDC. The Issuer also may provide references to the anchoring issuance proof seals. Everything else an Issuee (or recipient) needs to make a verifiable presentation/disclosure can be computed at the time of presentation/disclosure by the Issuee.

### Bulk-issued private ACDCs

The purpose of bulk issuance is to enable the Issuee to use ACDCs with unique SAIDs more efficiently to isolate and minimize correlation across different usage contexts. Each member of a set of bulk-issued ACDCs is essentially the same ACDC but with a unique SAID. This enables public commitments to each of the unique ACDC SAIDs without correlating between them. A private ACDC may be effectively issued in bulk as a set. In its basic form, the only difference between each ACDC is the top-level SAID, ‘d’, and UUID, ‘u’ field values. To elaborate, bulk issuance enables the use of uncorrelatable copies while minimizing the associated data transfer and storage requirements involved in the issuance. Essentially each copy (member) of a bulk-issued ACDC set shares a template that both the Issuer and Issuee use to generate on-the-fly a given ACDC in that set without requiring that the Issuer and Issuee exchange and store a unique copy of each member of the set independently. This minimizes the data transfer and storage requirements for both the Issuer and the Issuee. The Issuer is only required to provide a single signature for the bulk issued aggregate value ‘B’ defined below. The same signature may be used to provide proof of issuance of any member of the bulk-issued set. The signature on ‘B’ and ‘B’ itself are points of correlation but these need only be disclosed after Contractually protected disclosure is in place, i.e., no permissioned correlation. Thus, correlation requires a colluding Second-party who engages in unpermissioned correlation.

An ACDC provenance chain is connected via references to the SAIDs given by the top-level SAID, `d`, fields of the ACDCs in that chain.  A given ACDC thereby makes commitments to other ACDCs. Expressed another way, an ACDC may be a node in a directed graph of ACDCs. Each directed edge in that graph emanating from one ACDC includes a reference to the SAID of some other connected ACDC. These edges provide points of correlation to an ACDC via their SAID reference. Private bulk-issued ACDCs enable the Issuee to better control the correlatability of presentations using different presentation strategies.

For example, the Issuee could use one copy of a bulk-issued private ACDC per presentation even to the same Verifier. This strategy would consume the most copies. It is essentially a one-time-use ACDC strategy. Alternatively, the Issuee could use the same copy for all presentations to the same Verifier and thereby only permit the Verifier to correlate between presentations it received directly but not between other Verifiers. This limits the consumption to one copy per Verifier. In yet another alternative, the Issuee could use one copy for all presentations in a given context with a group of Verifiers, thereby only permitting correlation among that group.

This is about permissioned correlation. Any Verifier that has received a complete presentation of a private ACDC has access to all the fields disclosed by the presentation but the terms of the Chain-link confidentiality agreement may forbid sharing those field values outside a given context. Thus, an Issuee may use a combination of bulk-issued ACDCs with Chain-link confidentiality to control permissioned correlation of the contents of an ACDC while allowing the SAID of the ACDC to be more public. The SAID of a private ACDC does not expose the ACDC contents to an unpermissioned Third-party. Unique SAIDs belonging to bulk issued ACDCs prevent Third-parties from making a provable correlation between ACDCs via their SAIDs in spite of those SAIDs being public. This does not stop malicious Verifiers (as Second-
-parties) from colluding and correlating against the disclosed fields, but it does limit provable correlation to the information disclosed to a given group of malicious colluding Verifiers. To restate, unique SAIDs per copy of a set of private bulk issued ACDC prevent unpermissioned Third-parties from making provable correlations, in spite of those SAIDs being public, unless they collude with malicious Verifiers (Second-parties).

In some applications, Chain-link-confidentiality is insufficient to deter unpermissioned correlation. Some Verifiers may be malicious with sufficient malicious incentives to overcome whatever counter incentives the terms of the contractual Chain-link confidentiality may impose. In these cases, more aggressive technological anti-correlation mechanisms such as bulk issued ACDCs may be useful. To elaborate, in spite of the fact that Chain-link confidentiality terms of use may forbid such malicious correlation, making such correlation more difficult technically may provide better protection than Chain-link confidentiality alone [[ref: CLC]].

It is important to note that any group of colluding malicious Verifiers always may make a statistical correlation between presentations despite technical barriers to cryptographically provable correlation. This is called contextual linkability. In general, there is no cryptographic mechanism that precludes statistical correlation among a set of colluding Verifiers because they may make cryptographically unverifiable or unprovable assertions about information presented to them that may be proven as likely true using merely statistical correlation techniques. Linkability, due the context of the disclosure itself, may defeat any unlinkability guarantees of a cryptographic technique. Thus, without contractually protected disclosure, contextual linkability in spite of cryptographic unlinkability may make the complexity of using advanced cryptographic mechanisms to provide unlinkability an exercise in diminishing returns.

#### Basic bulk issuance proceedure

The amount of data transferred between the Issuer and Issuee (or recipient of an untargeted ACDC) at issuance of a set of bulk issued ACDCs may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUID, `u`, fields from a shared secret salt [[ref: Salt]].

As described above, there are several ways that the Issuer may share a secret salt securely. Given that the Issuer and Issuee (or recipient for Untargeted ACDCs) AIDs are each controlled by an Ed25519 key pair(s), a corresponding X15519 asymmetric encryption key pair(s) may be derived from the controlling Ed25519 key pair(s) [[ref: EdSC]][[ref: PSEd]][[ref: TMEd]]. An X25519 public key may be securely derived from an Ed25519 public key [[ref: KeyEx]][[ref: SKEM]]. Likewise, an X25519 private key may be securely derived from an Ed25519 private key [[ref: KeyEx]][[ref: SKEM]].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [[ref: KeyEx]][[ref: DHKE]]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used has high entropy cryptographic material from which the secret salt may be derived.

In a non-interactive approach, the Issuer derives an X25519 asymmetric public encryption key from the Issuee's (or recipient's) public Ed25519 public key. The Issuer then encrypts the secret salt with that public asymmetric encryption key and signs the encryption with the Issuer's private Ed25519 signing key. This is transmitted to the Issuee, who verifies the signature and decrypts the secret salt using the private X25519 decryption key derived from the Issuee's private Ed25519 key. This non-interactive approach is more scalable for AIDs that are controlled with a multi-sig group of signing keys. The Issuer can broadcast to all members of the Issuee's (or recipient's) multi-sig signing group individually asymmetrically encrypted and signed copies of the secret salt.

In addition to the secret salt, the Issuer also provides a template of the private ACDC but with empty UUID, `u`, and SAID, `d`, fields at the top-level of each nested block with such fields. Each UUID, `u`, field value is then derived from the shared salt with a deterministic path prefix that indexes both its membership in the bulk-issued set and its location in the ACDC. Given the UUID, `u`, field value, the associated SAID, `d`, field value may then be derived. Likewise, both full and compact versions of the ACDC may then be generated. This generation is analogous to that described in the section for Selective disclosure ACDCs but extended to a set of private ACDCs.

The initial element in each deterministic derivation path is the string value of the bulk-issued member's copy index ‘k’, such as ‘0’, ‘1’, ‘2’, etc.  Specifically, if ‘k denotes the index of an ordered set of bulk-issued private ACDCs of size ‘M, the derivation path starts with the string ‘k’, where ‘k is replaced with the decimal or hexadecimal textual representation of the numeric index ‘k’. Furthermore, a bulk-issued private ACDC with a private Attribute section uses ‘k’ to derive its top-level UUID and ‘k/0’ to derive its attribute section UUID. This hierarchical path is extended to any nested private attribute blocks. This approach is further extended to enable bulk-issued Selective disclosure ACDCs by using a similar hierarchical derivation path for the UUID field value in each of the selectively disclosable blocks in the array of attributes. For example, the path ‘k/j’ is used to generate the UUID of attribute index ‘j at bulk-issued ACDC index k’.

In addition to the shared salt and ACDC template, the Issuer also provides a list of signatures of SAIDs, one for each SAID of each copy of the associated compact bulk-issued ACDC.  The Issuee (or recipient) can generate on-demand each compact or uncompacted ACDC from the template, the salt, and its index ‘k’. The Issuee does not need to store a copy of each bulk-issued ACDC, merely the template, the salt, and the list of signatures.

The Issuer MUST  must anchor in its KEL an issuance proof digest seal of the set of bulk-issued ACDCs. The issuance proof digest seal makes a cryptographic commitment to the set of top-level SAIDS belonging to the bulk-issued ACDCs. This protects against later forgery of ACDCs in the event the Issuer's signing keys become compromised.  A later attempt at forgery requires a new event or new version of an event that includes a new anchoring issuance proof digest seal that makes a cryptographic commitment to the set of newly forged ACDC SAIDS. This new anchoring event of the forgery is therefore detectable.

Similarly, to the process of generating a Selective disclosure attribute ACDC, the issuance proof digest is an aggregate that is aggregated from all members in the bulk-issued set of ACDCs. The complication of this approach is that it must be done in such a way as to not enable provable correlation by a third party of the actual SAIDS of the bulk-issued set of ACDCs. Therefore, the actual SAIDs must not be aggregated but blinded commitments to those SAIDs instead. With blinded commitments, knowledge of any or all members of such a set does not disclose the membership of any SAID unless and until it is unblinded. Recall that the purpose of bulk issuance is to allow the SAID of an ACDC in a bulk issued set to be used publicly without correlating it in an unpermissioned provable way to the SAIDs of the other members.

The basic approach is to compute the aggregate denoted, ‘B’, as the digest of the concatenation of a set of blinded digests of bulk issued ACDC SAIDS. Each ACDC SAID is first blinded via concatenation to a UUID (salty nonce) and then the digest of that concatenation is concatenated with the other blinded SAID digests. Finally, a digest of that concatenation provides the aggregate.

Suppose there are ‘M’ ACDCs in a bulk issued set. Using zero-based indexing for each member of the bulk-issued set of ACDCs, such that index ‘k’ satisfies ‘k’ in \{0, ..., M-1\}, let <sub>k</sub> denote the top-level SAID of an ACDC in an ordered set of bulk-issued ACDCs. Let v<sub>k</sub> denote the UUID (salty nonce) or blinding factor that is used to blind that said. The blinding factor, v<sub>k</sub>, is not the top-level UUID, `u`, field of the ACDC itself but an entirely different UUID used to blind the ACDC's SAID for the purpose of aggregation. The derivation path for v<sub>k</sub> from the shared secret salt is ‘k’, where ‘k’ is the index of the bulk-issued ACDC.

Let c<sub>k</sub> = v<sub>k</sub> + d<sub>k</sub> denote the blinding concatenation where ‘+’ is the infix concatenation operator.
Then the blinded digest, b<sub>k</sub>, is given by,
b<sub>k</sub> = H(c<sub>k</sub>) = H(v<sub>k</sub> + d<sub>k</sub>),
where H is the digest operator. Blinding is performed by a digest of the concatenation of the binding factor, v<sub>k</sub>, with the SAID, d<sub>k</sub> instead of XORing the two. An XOR of two elements whose bit count is much greater than 2 is not vulnerable to a birthday table attack [[ref: BDay]] [[ref: DRB]] [[ref: BDC]]. In order to XOR, however, the two must be of the same length. Different SAIDs MAY be of different lengths, however, and therefore, may require different length blinding factors. Because concatenation is length independent it is simpler to implement.

The aggregation of blinded digests, ‘B’, is given by,
B = H(C(b<sub>k</sub> for all k in \{0, ..., M-1\})),
where ‘C’ is the concatenation Operator and ‘H’ is the digest Operator. This aggregate, ‘B’, provides the issuance proof digest.

The aggregate, ‘B’, makes a blinded cryptographic commitment to the ordered elements in the li’t \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] A commitment to ‘B’ is a commitment to all the b<sub>k</sub> and hence all the d<sub>k</sub>.

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [[ref: BDC]][[ref: BDay]][[ref: QCHC]][[ref: HCR]][[ref: Hash]].

Disclosure of any given b<sub>k</sub> element does not expose or disclose any discoverable information detail about either the SAID of its associated ACDC or any other ACDC's SAID. Therefore, the full list of b<sub>k</sub> elements can be disclosed safely without exposing the blinded bulk issued SAID values, d<sub>k</sub>.

Proof of inclusion in the list of blinded digests consists of checking the list for a matching value. A computationally efficient way to do this is to create a hash table or B-tree of the list and then check for inclusion via lookup in the hash table or B-tree.

A proof of inclusion of an ACDC in a bulk-issued set requires disclosure of v<sub>k</sub> which is only disclosed after the Disclosee has accepted (agreed to) the terms of the rule section. Therefore, in the event the Disclosee declines to accept the terms of disclosure, then a presentation/disclosure of the compact version of the ACDC does not provide any point of correlation to any other SAID of any other ACDC from the bulk set that contributes to the aggregate ‘B’. In addition, because the other SAIDs are hidden by each b<sub>k</sub> inside the aggregate, ‘B’, even a presentation/disclosure of, \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\]oes not provide any point of correlation to the actual bulk-issued ACDC without disclosure of its v<sub></sub>. Indeed, if the Discloser uses a metadata version of the ACDC in its offer, then even its SAID is not disclosed until after acceptance of terms in the rule section.

To protect against later forgery given a later compromise of the signing keys of the Issuer, the Issuer must anchor an issuance proof seal to the ACDC in its KEL. This seal binds the signing Key state to the issuance. There are two cases. In the first case, an issuance/revocation registry is used. In the second case, an issuance/revocation registry is not used.

When the ACDC is registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the issuance (Inception) event in the ACDC's TEL entry. The issuance event in the TEL uses the aggregate value, ‘B’, as its identifier value. This binds the aggregate, ‘B’, to the issuance proof seal in the Issuer's KEL through the TEL.

Recall that the usual purpose of a TEL is to provide a Verifiable data registry that enables dynamic revocation of an ACDC via a state of the TEL. A Verifier checks the state at the time of use to check if the associated ACDC has been revoked. The Issuer controls the state of the TEL. The registry identifier, `ri`, field is used to identify the public registry which usually provides a unique TEL entry for each ACDC. Typically, the identifier of each TEL entry is the SAID of the TEL's Inception event which is a digest of the event's contents which include the SAID of the ACDC. In the bulk issuance case, however, the TEL's Inception event contents include the aggregate, ‘B’, instead of the SAID of a given ACDC. Recall that the goal is to generate an aggregate value that enables an Issuee to selectively disclose one ACDC in a bulk-issued set without leaking the other members of the set to unpermissioned parties (second or third).

Using the aggregate, ‘B’ of blinded ACDC SAIDs as the TEL registry entry identifier allows all members of the bulk-issued set to share the same TEL without any Third-party being able to discover which TEL any ACDC is using in an unpermissioned provable way. Moreover, a Second-party may not discover in an unpermissioned way any other ACDCs from the bulk-issued set not specifically disclosed to that Second-party. In order to prove to which TEL a specific bulk issued ACDC belongs, the full inclusion proof must be disclosed.

When the ACDC is not registered using an issuance/revocation TEL then the issuance proof seal digest is the aggregate, ‘B’, itself.

In either case, this issuance proof seal makes a verifiable binding between the issuance of all the ACDCs in the bulk issued set and the Key state of the Issuer at the time of issuance.

A Disclosee may make a basic provable non-repudiable selective disclosure of a given bulk issued ACDC, at index ‘k’ by providing to the Disclosee four items of information (proof of inclusion). These are as follows:

- The ACDC in compact form (at index ‘k’) where ‘d<sub>k</sub> as the value of its top-level SAID, `d`, field.
- The blinding factor, v<sub>k</sub> from which b<sub>k</sub> = H(v<sub>k</sub> + d<sub>k</sub>) may be computed.
- The list of all blinded SAIDs, \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] that includes b<sub>k</sub>*.
- A reference to the anchoring seal in the Issuer's KEL or TEL that references the aggregate ‘B’. The event that references the seal or the TEL event that references ‘B’ must be signed by the issuer so the signature on either event itself is sufficient to prove authorized issuance.

The aggregate ‘B’ is a point of unpermissioned correlation but not permissioned correlation. To remove ‘B’ as a point of unpermissioned correlation requires using independent TEL bulk-issued ACDCs described in the section so named below.

A Disclosee may then verify the disclosure by:

- computing d<sub>j</sub> on the disclosed compact ACDC.
- computing b<sub>k</sub> = H(v<sub>k</sub> + d<sub>k</sub>).
- confirming that the compute b<sub>k</sub> appears in the provided list \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\].
- computing the aggregate ‘B’ from the provided list [b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\]..
- confirming the presence of an issuance seal digest in the Issuer's KEL that makes a commitment to the aggregate, ‘B’, either directly or indirectly through a TEL registry entry. This provides proof of authorized issuance.

The last 3 steps that culminate with verifying the anchoring seal also require verifying the Key state of the Issuer at the time of issuance, this may require additional verification steps as per the KERI, PTEL, and CESR-Proof protocols.

The requirement of an anchored issuance proof seal of the aggregate ‘B’ means that the forger must first successfully publish in the KEL of the Issuer an inclusion proof digest seal bound to a set of forged bulk-issued ACDCs. This makes any forgery attempt detectable. To elaborate, the only way to successfully publish such a seal is in a subsequent Interaction event in a KEL that has not yet changed its Key state via a Rotation event. Whereas any KEL that has changed its Key state via a Rotation must be forked before the Rotation. This makes the forgery attempt either both detectable and recoverable via Rotation in any KEL that has not yet changed its Key state or detectable as Duplicity in any KEL that has changed its Key state. In any event, the issuance proof seal makes any later attempt at forgery using compromised keys detectable.

#### Inclusion proof via Merkle tree 

The inclusion proof via aggregated list may be somewhat verbose when there are a very large number of bulk-issued ACDCs in a given set. A more efficient approach is to create a Merkle tree of the blinded SAID digests, b<sub>k</sub> and set the aggregate ‘B’ value as the Merkle tree root digest [[ref: Mrkl]].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [[ref: TwoPI]][[ref: MTSec]]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, b<sub>k</sub> contributed to the Merkle tree root digest. For a small-numbered bulk-issued set of ACDCs, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Bulk issuance of private ACDCs with unique issuee AIDs 

One potential point of provable but unpermissioned correlation among any group of colluding malicious Disclosees (Second-party Verifiers) may arise when the same Issuee AID is used for presentation/disclosure to all Disclosees in that group. Recall that the contents of private ACDCs are not disclosed except to permissioned Disclosees (Second-parties). Thus, a common Issuee AID would be a point of correlation only for a group of colluding malicious verifiers. But in some cases removing this unpermissioned point of correlation may be desirable.

One solution to this problem is for the Issuee to use a unique AID for the copy of a bulk-issued ACDC presented to each Disclosee in a given context. This requires that each ACDC copy in the bulk-issued set use a unique Issuee AID. This would enable the Issuee in a given context to minimize provable correlation by malicious Disclosees against any given Issuee AID. In this case, the bulk issuance process may be augmented to include the derivation of a unique Issuee AID in each copy of the bulk-issued ACDC by including in the Inception event that defines a given Issuee's self-addressing AID, a digest seal derived from the shared salt and copy index ‘k’. The derivation path for the digest seal is ‘k/0.’, where ‘k’ is the index of the ACDC. To clarify ‘k/0.’ specifies the path to generate the UUID to be included in the Inception event that generates the Issuee AID for the ACDC at index ‘k’. This can be generated on-demand by the Issuee. Each unique Issuee AID also would need its own KEL. But generation and publication of the associated KEL can be delayed until the bulk-issued ACDC is actually used. This approach completely isolates a given Issuee AID to a given context with respect to the use of a bulk-issued private ACDC. This protects against even the unpermissioned correlation among a group of malicious Disclosees (Second-parties) via the Issuee AID.


### Independent Registry bulk-issued ACDCs

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/33
:::

Recall that the purpose of using the aggregate ‘B for a bulk-issued set from which the Registry identifier is derived is to enable a set of bulk-issued ACDCs to share a single public Registry and/or a single anchoring seal in the Issuer's KEL without enabling unpermissioned correlation to any other members of the bulk set by virtue of the shared aggregate ‘B’ used for either the TEL or anchoring seal in the KEL. When using a TEL as Registry, this enables the issuance/revocation/transfer state of all copies of a set of bulk-issued ACDCs to be provided by a single Registry which minimizes the storage and compute requirements on the Registry while providing Selective disclosure to prevent unpermissioned correlation via the public TEL Registry. When using an anchoring seal, this enables one signature to provide proof of inclusion in the bulk-issued aggregate ‘B’.

However, in some applications where Chain-link confidentiality does not sufficiently deter malicious provable correlation by Disclosees (Second-party Verifiers), an Issuee may benefit from using ACDC with independent TELs or independent aggregates ‘B’ but that are still bulk-issued.

In this case, the bulk issuance process must be augmented so that each uniquely identified copy of the ACDC gets its own TEL entry (or equivalently its own aggregate ‘B’) in the registry. Each Disclosee (Verifier) of a full presentation/disclosure of a given copy of the ACDC only receives proof of one uniquely identified TEL and cannot provably correlate the TEL state of one presentation to any other presentation because the ACDC SAID, the TEL identifier, and the signature of the Issuer on each aggregate ‘B’ will be different for each copy. There is, therefore, no point of provable correlation, permissioned or otherwise. For example, this approach could be modulated by having a set of smaller bulk issued sets that are more contextualized than one large bulk-issued set.

The obvious drawbacks of this approach (independent unique TELs for each private ACDC) are that the size of the registry database increases as a multiple of the number of copies of each bulk-issued ACDC and every time an Issuer must change the TEL state of a given set of copies it must change the state of multiple TELs in the registry. This imposes both a storage and computation burden on the registry. The primary advantage of this approach, however, is that each copy of a private ACDC has a uniquely identified TEL. This minimizes unpermissioned Third-party exploitation via provable correlation of TEL identifiers even with colluding Second-party Verifiers. They are limited to statistical correlation techniques.

In this case, the set of private ACDCs may or may not share the same Issuee AID because for all intents and purposes each copy appears to be a different ACDC even when issued to the same Issuee. Nonetheless, using unique Issuee AIDs may further reduce correlation by malicious Disclosees (Second-party verifiers) beyond using independent TELs.

To summarize the main benefit of this approach, in spite of its storage and compute burden, is that in some applications Chain-link confidentiality does not sufficiently deter unpermissioned malicious collusion. Therefore, completely independent bulk-issued ACDCs may be used.


### Extensibility

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/35
:::

The ACDC design leverages append-only verifiable data structures, namels KELs and TELs that have strong security properties that simplify end-verifiability and foster decentralization. Append-only verifiable data structures provide permission-less extensibility by issuers, presenters, and/or verifiers. By permission-less, it means that there is no shared governance over these data structures. This is completely decentralized and zero-trust. The fact that each ACDC has both a universally unique content-based identifier and a universally unique content-based schema identifier that determines its type, enables permission-less ACDC type registries. Because attributes, claims, properties may be conveyed by verifiable graphs of ACDCs linked by their edges whose edges may also have properties, ACDCs may be modeled as labeled property graphs. Thus enables extensibility of pre-existing already Issued ACDCs by appending additional attributes via application specifc ACDCs or bespoke ACDCs. In other words, custom attributes or properties are appended via chaining via one or more custom ACDCs defined by custom schema (type-is-schema), not modifying in place pre-issued credential types.

In essence, an ACDC is really just a verifiable property graph fragment of an extensible distributed property graph where each node may be sourced by a different issuer. This type of extensibility means there is no need for centralized permissioned name-space registries to resolve name-space collisions of attributes or properties. Each ACDC has a universally unique content address and a universally unique content addressable schema (type-is-schema) as ACDC type that defines the namespace. The function of an extensible registry of ACDC types now becomes merely schema discovery or schema blessing for a given context or ecosystem. The reach of such a registry of ACDC types can be tuned to the reach of desired interoperability by the ecosystem participants. Versioning is also simplified because edges may still verify if the new schema is backward compatible.

### ACDC protocol message types

CESR support for the ACDC protocol includes conveying sections of an ACDC as CESR-compatible messages (packets). These messages can be part of a CESR stream or part of the attachment group to an ACDC. This is useful for sending the ACDC in its compact form and then attaching the section details as individual message packets. This enables one to cache sections so that they do not have to be transmitted repeatedly or reuse sections that are the same for multiple ACDC instances, which is often the case for the schema and rule sections. An ACDC message itself may have as an option a message type field. This allows CESR native versions of ACDCs. The default is that absent a message type field, an ACDC protocol message given by the version string field is an ACDC. All other message types shall have the message type field. The following table provides all the message types (ilks) for the ACDC protocol. The message type (ilk) field label is `t` and shall appear at the top-level immediately following the version string, `v` field.

#### Message type table

|Ilk|Name|Description|
|---|---|---|
|     |      | Registry TEL Message Types|
| rip | Registry Inception | Initialize blindable state ACDC registry |
| upd | Update | Update transaction state of blindable state ACDC registry |
|     |        | ACDC Message |
|     | ACDC | Default ACDC without message type (ilk), `t` field |
| acd | ACDC | With message type (ilk), `t` field |
|     |        | ACDC Section message types |
| sch | Schema | Schema section message |
| att | Attribute | Attribute section message |
| agg | Aggregate | Attribute aggregate section message |
| edg | Edge | Edge section message |
| rul | Rule | Rule section message |



#### ACDC message with message type field

The following table defines the top-level fields in an ACDC with a message type field and their order of appearance. Some fields are optional, but all fields that appear shall appear in this order, `[v, t, d, u, i, s, a, A, e, r]`.

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: ACDCvvSSSShhhhhh_ that provides protocol type, version, serialization type, size, and terminator. |
|`t`| Message Type| Three character message type |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Issuer Identifier (AID)| Autonomic Identifier whose control authority is established via KERI verifiable key state. |
|`rd`| Registry Digest (SAID) | Issuance and/or revocation, transfer, or retraction registry for ACDC |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of edges or the block itself.|
|`r`| Rule | Either the SAID a block of rules or the block itself. |


The message type field enables fixed fields at the top level for an even more compact ACDC. The SAD of an ACDC is a labeled field map, such as an object in Javascript, or a dict in Python. The over-the-wire serialization could be CESR with fixed fields. Shown below is the labeled SAD as a Python dict(not the over-the-wire JSON or CESR).  The message type, `t` field for ACDCs is an optional field for JSON, CBOR, MGPK, and CESR field maps but is required for CESR fixed fields. This enables  more than one type of CESR fixed field top-level ACDC CESR serialization that is unambiguously parseable. This seems to violate the schema-is-type convention in order to enable a parser to correctly parse a fixed field message type.

Python dict of compact ACDC with message type, `t` field.

```python
{
  "v":  "ACDCCAAJSONAACD_",
  "t":  "acd",
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "u":  "0AHcgNghkDaG7OY1wjaDAE0q",
  "i":  "EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4re",
  "a":  "EFrn9y2PYgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lk",
  "e":  "ECdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3d",
  "r":  "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR"
}
```

#### Section message fields

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: ACDCvvSSSShhhhhh_ that provides protocol type, version, serialization type, size, and terminator. |
|`t`| Message Type| Three character message type |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of edges or the block itself.|
|`r`| Rule | Either the SAID a block of rules or the block itself. |

Each section message must have version string, `v`, message type, `t`,  and SAID, `d` fields in that order. The value of the SAID, `d` field is the said of the message block itself not the SAID of the embedded section field value. The embedded section block's SAID, `d` field should match the section field value in the associated compact ACDC.

The remaining field is the appropriate section field for the message type, as follows: 

- schema, `s` field for the schema, `sch` message
- attribute, `a` field for the attribute, `att` message
- attribute aggregate, `A` field for the aggregate, `agg` message
- edge, `e` field for the edge, `edg` message
- rule, `r` field for the rule, `rul` message

For the following messages, except for the attribute aggregate variant, assume that the associated compact ACDC is as follows:
Compact form with attribute section:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "t":  "acd",
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "u":  "0AHcgNghkDaG7OY1wjaDAE0q",
  "i":  "EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "a":  "EFrn9y2PYgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lk",
  "e":  "ECdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3d",
  "r":  "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR"
}
```
For the the attribute aggregate variant below, assume that the associated compact ACDC is as follows:

Compact form with attribute aggregate section:

```json
{
  "v":  "ACDCCAAJSONAACD_",
  "t":  "acd",
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "u":  "0AHcgNghkDaG7OY1wjaDAE0q",
  "i":  "EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr",
  "rd": "EAMPAI6FkekwlOjkggtymRy7xMwsxUelUauaXtMxTfP",
  "s":  "EAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4re",
  "A":  "ELIr9Bf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzw",
  "e":  "ECdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3d",
  "r":  "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR"
}
```

#### Schema section message

The schema, `s` field value is the expanded schema section from the associated ACDC. Notice that the value of the `$id` field within the schema subblock matches the value of the schema, `s` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD_",
  "t": "sch", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "s": 
  {
    "$id": "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
    "$schema": "https://json-schema.org/draft/2020-12/schema",
    "title": "Compact Public ACDC",
    "description": "Example JSON Schema for a Compact private ACDC.",
    "credentialType": "CompactPublicACDCExample",
    "version": "1.0.0",
    "type": "object",
    "required":
    [
      "v",
      "d",
      "u",
      "i",
      "rd",
      "s",
      "a",
      "e",
      "r"
    ],
    "properties":
    {
      "v":
      {
        "description": "ACDC version string",
        "type": "string"
      },
      "d":
      {
        "description": "ACDC SAID",
        "type": "string"
      },
      "i":
      {
        "description": "Issuer AID",
        "type": "string"
      },
      "rd":
      {
        "description": "Registry SAID",
        "type": "string"
      },
      "s": 
      {
        "description": "schema SAID",
        "type": "string"
      },
      "a": 
      {
        "description": "attribute SAID",
        "type": "string"
      },
      "e": 
      {
        "description": "edge SAID",
        "type": "string"
      },
      "r": 
      {
        "description": "rule SAID",
        "type": "string"
      }
    },
    "additionalProperties": false
  }
}
```

#### Attribute section message

The attribute, `a` field value is the expanded attribute section from the associated ACDC. Notice that the value of the `d` field within the attribute subblock matches the value of the attribute, `a` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD_",
  "t": "att", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "a": 
  {
    "d": "EFrn9y2PYgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lk",
    "i": "EKAn2EDIPmkPreYApZfFk66jpf3uFv7vklXKhzBrAqjs",
    "temp": 45,
    "lat": "N40.3433",
    "lon": "W111.7208"
  }
}
```

#### Aggregated Attribute Message

The attribute aggregate, `A` field value is the expanded attribute aggregate section from the associated ACDC. Notice that the value of the attribute aggregate, `A` field in the associated ACDC above, is computed as the digest of concatenated digests of the elements of the selectively disclosable Array (see the Annex on selective disclosure).


```json
{
  "v": "ACDCCAAJSONAACD_",
  "t": "agg", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "A":
  [
    {
      "d": "ErzwLIr9Bf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUde",
      "u": "0AqHcgNghkDaG7OY1wjaDAE0",
      "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA"
    },
    {
      "d": "ELIr9Bf7V_NHwY1lkgveY4-Frn9y2PY9XgOcLxUderzw",
      "u": "0AG7OY1wjaDAE0qHcgNghkDa",
      "score": 96
    },
    {
      "d": "E9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PYgveY4-",
      "u": "0AghkDaG7OY1wjaDAE0qHcgN",
      "name": "Jane Doe"
    }
  ]
}
```

#### Edge Message
The edge, `e` field value is the expanded edge section from the associated ACDC. Notice that the value of the `d` field within the edge subblock matches the value of the edge, `e` field in the associated ACDC above.


```json
{
  "v": "ACDCCAAJSONAACD_",
  "t": "edg", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "e": 
  {
    "d": "ECdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOARH3d",
    "poe": "ECJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2BBWNHdSX",
    "poa":
    {
      "o": "OR",
      "sewer": "EK0neuniccMBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5",
      "gas": "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B"
    }
  }
}
```

#### Rule Message
The rule, `r` field value is the expanded rule section from the associated ACDC. Notice that the value of the `d` field within the rule subblock matches the value of the rule, `r` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD_",
  "t": "rul", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "r": 
  {
    "d": "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR",
    "disclaimers":
    {
      "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:"
      "warrantyDisclaimer": "Issuer provides this ACDC on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE",
      "liabilityDisclaimer": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    },
    "permittedUse": "The person or legal entity identified by the ACDC's Issuee AID (Issuee) agrees to only use the information contained in this ACDC for non-commercial purposes."
  }
}
```


### ACDC Examples 

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/27
:::

Public ACDC with compact and uncompacted variants

Public compact variant

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "ERH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOA",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

Public uncompacted variant

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":
  {
    "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
    "i": "did:keri:EpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPmkPreYA",
    "score": 96,
    "name": "Jane Doe"
  },
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss":
    {
      "d": "E9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn",
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "s": "EiheqcywJcnjtJtQIYPvAu6DZAIl3MORH3dCdoFOLe71",
      "w": "high"
    }
  },
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "warrantyDisclaimer":
    {
      "d": "EXgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
      "l": "Issuer provides this credential on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE"
    },
    "liabilityDisclaimer":
    {
      "d": "EY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw",
      "l": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    }
  }
}
```

Composed schema that supports both public compact and uncompacted variants

```json
{
  "$id": "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Public ACDC",
  "description": "Example JSON Schema Public ACDC.",
  "credentialType": "PublicACDCExample",
  "type": "object",
   "required":
  [
    "v",
    "d",
    "i",
    "rd",
    "s",
    "a",
    "e",
    "r"
  ],
  "properties":
  {
    "v":
    {
      "description": "ACDC version string",
      "type": "string"
    },
    "d":
    {
     "description": "ACDC SAID",
      "type": "string"
    },
    "i":
    {
      "description": "Issuer AID",
      "type": "string"
    },
    "rd":
    {
      "description": "Registry SAID",
      "type": "string"
    },
    "s":
    {
      "description": "schema section",
      "oneOf":
      [
        {
          "description": "schema section SAID",
          "type": "string"
        },
        {
          "description": "schema detail",
          "type": "object"
        }
      ]
    },
    "a":
    {
      "description": "attribute section",
      "oneOf":
      [
        {
          "description": "attribute section SAID",
          "type": "string"
        },
        {
          "description": "attribute detail",
          "type": "object",
          "required":
          [
            "d",
            "i",
            "score",
            "name"
          ],
          "properties":
          {
            "d":
            {
              "description": "attribute section SAID",
              "type": "string"
            },
            "i":
            {
              "description": "Issuee AID",
              "type": "string"
            },
            "score":
            {
              "description": "test score",
              "type": "integer"
            },
            "name":
            {
              "description": "test taker full name",
              "type": "string"
            }
          },
          "additionalProperties": false
        }
      ]
    },
    "e":
    {
      "description": "edge section",
      "oneOf":
      [
        {
          "description": "edge section SAID",
          "type": "string"
        },
        {
          "description": "edge detail",
          "type": "object",
          "required":
          [
            "d",
            "boss"
          ],
          "properties":
          {
            "d":
            {
              "description": "edge section SAID",
              "type": "string"
            },
            "boss":
            {
              "description": "boss edge",
              "type": "object",
              "required":
              [
                "d",
                "n",
                "s",
                "w"
              ],
              "properties":
              {
                "d":
                {
                  "description": "edge SAID",
                  "type": "string"
                },
                "n":
                {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s":
                {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "EiheqcywJcnjtJtQIYPvAu6DZAIl3MORH3dCdoFOLe71"
                },
                "w":
                {
                  "description": "edge weight",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          },
          "additionalProperties": false
        }
      ]
    },
    "r":
    {
      "description": "rule section",
      "oneOf":
      [
        {
          "description": "rule section SAID",
          "type": "string"
        },
        {
          "description": "rule detail",
          "type": "object",
          "required":
          [
            "d",
            "warrantyDisclaimer",
            "liabilityDisclaimer"
          ],
          "properties":
          {
            "d":
            {
              "description": "edge section SAID",
              "type": "string"
            },
            "warrantyDisclaimer":
            {
              "description": "warranty disclaimer clause",
              "type": "object",
              "required":
              [
                "d",
                "l"
              ],
              "properties":
              {
                "d":
                {
                  "description": "clause SAID",
                  "type": "string"
                },
                "l":
                {
                  "description": "legal language",
                  "type": "string"
                }
              },
              "additionalProperties": false
            },
            "liabilityDisclaimer":
            {
              "description": "liability disclaimer clause",
              "type": "object",
              "required":
              [
                "d",
                "l"
              ],
              "properties":
              {
                "d":
                {
                  "description": "clause SAID",
                  "type": "string"
                },
                "l":
                {
                  "description": "legal language",
                  "type": "string"
                }
              },
              "additionalProperties": false
            }
          },
          "additionalProperties": false
        }
      ]
    }
  },
  "additionalProperties": false
}
```


[//]: # (\backmatter)

[//]: # (Performance and Scalability {#sec:annexA .informative})

[//]: # (\newpage)

[//]: # (\makebibliography)

[//]: # (# Bibliography)

[[def: Composable Event Streaming Representation, CESR]]

~ https://github.com/trustoverip/tswg-acdc-specification

[[def: Key Event Receipt Infrastructure, KERI]]

~ https://github.com/trustoverip/tswg-keri-specification

[[def: Self-Addressing IDentifier, SAID]]

~ https://github.com/trustoverip/tswg-cesr-specification

[[def: Out-Of-Band-Introduction, OOBI]]

~ https://github.com/trustoverip/tswg-keri-specification

[[def: DIDK_ID, IETF DID-KERI Internet Draft]]

~ https://github.com/WebOfTrust/ietf-did-keri

[[def: RFC6901, JavaScript Object Notation (JSON) Pointer]]

~ https://datatracker.ietf.org/doc/html/rfc6901

[[def: JSON, JavaScript Object Notation Delimeters]]

~ https://www.json.org/json-en.html

[[def: RFC8259, JSON (JavaScript Object Notation)]]

~ https://datatracker.ietf.org/doc/html/rfc8259

[[def: RFC4627, The application/json Media Type for JavaScript Object Notation (JSON)]]

~ https://datatracker.ietf.org/doc/rfc4627/

[[def: JSch, JSON Schema]]

~ https://json-schema.org

[[def: JSch_202012, JSON Schema 2020-12]]

~ https://json-schema.org/draft/2020-12/release-notes.html

[[def: CBOR, CBOR Mapping Object Codes]]

~ https://en.wikipedia.org/wiki/CBOR

[[def: RFC8949, Concise Binary Object Representation (CBOR)]]

~ https://datatracker.ietf.org/doc/rfc8949/

[[def: MGPK, Msgpack Mapping Object Codes]]

~ https://github.com/msgpack/msgpack/blob/master/spec.md

[[def: RFC3986, Uniform Resource Identifier (URI): Generic Syntax]]

~ https://datatracker.ietf.org/doc/html/rfc3986

[[def: RFC8820, URI Design and Ownership]]

~ https://datatracker.ietf.org/doc/html/rfc8820

[[def: ACDC_WP, Authentic Chained Data Containers (ACDC) White Paper]]

~ https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/ACDC.web.pdf

[[def: VCEnh, VC Spec Enhancement Strategy Proposal]]

~ https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/VC_Enhancement_Strategy.md

[[def: ACDC_TF, ACDC (Authentic Chained Data Container) Task Force]]

~ https://wiki.trustoverip.org/display/HOME/ACDC+%28Authentic+Chained+Data+Container%29+Task+Force

[[def: TOIP, Trust Over IP (ToIP) Foundation]]

~ https://trustoverip.org

[[def: IETF, Internet Engineering Task Force]]

~ https://www.ietf.org

[[def: KERI, Key Event Receipt Infrastructure (KERI)]]

~ https://arxiv.org/abs/1907.02143

[[def: ITPS, Information-Theoretic and Perfect Security]]

~ https://en.wikipedia.org/wiki/Information-theoretic_security

[[def: OTP, One-Time-Pad]]

~ https://en.wikipedia.org/wiki/One-time_pad

[[def: VCphr, Vernom Cipher (OTP)]]

~ https://www.ciphermachinesandcryptology.com/en/onetimepad.htm

[[def: SSplt, Secret Splitting]]

~ https://www.ciphermachinesandcryptology.com/en/secretsplitting.htm

[[def: SShr, Secret Sharing]]

~ https://en.wikipedia.org/wiki/Secret_sharing

[[def: CSPRNG, Cryptographically-secure pseudorandom number generator (CSPRNG)]]

~ https://en.wikipedia.org/wiki/Cryptographically-secure_pseudorandom_number_generator

[[def: IThry, Information Theory]]

~ https://en.wikipedia.org/wiki/Information_theory

[[def: CAcc, Cryptographic Accumulator]]

~ https://en.wikipedia.org/wiki/Accumulator_(cryptography)

[[def: XORA, XORA (XORed Accumulator)]]

~ https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/XORA.md

[[def: GLEIF, GLEIF (Global Legal Entity Identifier Foundation)]]

~ https://www.gleif.org/en/

[[def: vLEI, vLEI (verifiable Legal Entity Identifier) Definition]]

~ https://github.com/WebOfTrust/vLEI

[[def: GLEIF_vLEI, GLEIF vLEI (verifiable Legal Entity Identifier)]]

~ https://www.gleif.org/en/lei-solutions/gleifs-digital-strategy-for-the-lei/introducing-the-verifiable-lei-vlei

[[def: GLEIF_KERI, GLEIF with KERI Architecture]]

~ https://github.com/WebOfTrust/vLEI

[[def: W3C_VC, W3C Verifiable Credentials Data Model v1.1]]

~ https://www.w3.org/TR/vc-data-model/

[[def: W3C_DID, W3C Decentralized Identifiers (DIDs) v1.0]]

~ https://w3c-ccg.github.io/did-spec/

[[def: Salt, Salts, Nonces, and Initial Values]]

~ https://medium.com/@fridakahsas/salt-nonces-and-ivs-whats-the-difference-d7a44724a447

[[def: RB, Rainbow Table]]

~ https://en.wikipedia.org/wiki/Rainbow_table

[[def: DRB, Dictionary Attacks, Rainbow Table Attacks and how Password Salting defends against them]]

~ https://www.commonlounge.com/discussion/2ee3f431a19e4deabe4aa30b43710aa7

[[def: BDay, Birthday Attack]]

~ https://en.wikipedia.org/wiki/Birthday_attack

[[def: BDC, Birthday Attacks, Collisions, And Password Strength]]

~ https://auth0.com/blog/birthday-attacks-collisions-and-password-strength/

[[def: HCR, Hash Collision Resistance]]

~ https://en.wikipedia.org/wiki/Collision_resistance

[[def: QCHC, Cost analysis of hash collisions: Will quantum computers make SHARCS obsolete?]]

~ https://cr.yp.to/hash/collisioncost-20090823.pdf

[[def: EdSC, The Provable Security of Ed25519: Theory and Practice Report]]

~ https://eprint.iacr.org/2020/823

[[def: PSEd, The Provable Security of Ed25519: Theory and Practice]]

~ https://ieeexplore.ieee.org/document/9519456?denied=

[[def: TMEd, Taming the many EdDSAs]]

~ https://eprint.iacr.org/2020/1244.pdf

[[def: JSchCp, Schema Composition in JSON Schema]]

~ https://json-schema.org/understanding-json-schema/reference/combining.html

[[def: JSchRE, Regular Expressions in JSON Schema]]

~ https://json-schema.org/understanding-json-schema/reference/regular_expressions.html

[[def: JSchId, JSON Schema Identification]]

~ https://json-schema.org/understanding-json-schema/structuring.html#schema-identification

[[def: JSchCx, Complex JSON Schema Structuring]]

~ https://json-schema.org/understanding-json-schema/structuring.html#base-uri

[[def: RC, Ricardian Contract]]

~ https://en.wikipedia.org/wiki/Ricardian_contract

[[def: CLC, Chain-Link Confidentiality]]

~ https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2045818

[[def: DHKE, Diffie-Hellman Key Exchange]]

~ https://www.infoworld.com/article/3647751/understand-diffie-hellman-key-exchange.html

[[def: KeyEx, Key Exchange]]

~ https://libsodium.gitbook.io/doc/key_exchange

[[def: IDSys, Identity System Essentials]]

~ https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/Identity-System-Essentials.pdf

[[def: Hash, Cryptographic Hash Function]]

~ https://en.wikipedia.org/wiki/Cryptographic_hash_function

[[def: Mrkl, Merkle Tree]]

~ https://en.wikipedia.org/wiki/Merkle_tree

[[def: TwoPI, Second Pre-image Attack on Merkle Trees]]

~ https://flawed.net.nz/2018/02/21/attacking-merkle-trees-with-a-second-preimage-attack/

[[def: MTSec, Merkle Tree Security]]

~ https://blog.enuma.io/update/2019/06/10/merkle-trees-not-that-simple.html

[[def: DSig, Digital Signature]]

~ https://en.wikipedia.org/wiki/Digital_signature

[[def: Level, Security Level]]

~ https://en.wikipedia.org/wiki/Security_level

[[def: Twin, Digital Twin]]

~ https://en.wikipedia.org/wiki/Digital_twin

[[def: TMal, Transaction Malleability]]

~ https://en.wikipedia.org/wiki/Transaction_malleability_problem

[[def: PGM, The Property Graph Database Model]]

~ http://ceur-ws.org/Vol-2100/paper26.pdf

[[def: Dots, Constructions from Dots and Lines]]

~ https://arxiv.org/pdf/1006.2361.pdf

[[def: KG, Knowledge Graphs]]

~ https://arxiv.org/pdf/2003.02320.pdf

[[def: Abuse, Alice Attempts to Abuse a Verifiable Credential]]

~ https://github.com/WebOfTrustInfo/rwot9-prague/blob/master/final-documents/alice-attempts-abuse-verifiable-credential.md

[[def: SKEM, On using the same key pair for Ed25519 and an X25519 based KEM]]

~ https://eprint.iacr.org/2021/509

[[spec]]
