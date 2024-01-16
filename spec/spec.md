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

An Authentic chained data container (ACDC) specification [@ACDC_ID][@ACDC_WP][@VCEnh] is being incubated at the ToIP (Trust over IP) Foundation [@TOIP][@ACDC_TF].  An ACDC is a compliant external proof format of the W3C VC 2.0 specification.  The ACDC specification supports the use of KERI-based (Key Event Receipt Infrastructure) DID methods such as did:KERI and did:webs as primary identifiers  (W3C DID (Decentralized Identifier) specification [@W3C_DID]. A major use case for the ACDC specification is the use of ACDCs as vLEIs (verifiable Legal Entity Identifiers) within the ecosystem and infrastructure developed by[@vLEI][@GLEIF_vLEI][@GLEIF_KERI]. the Global Legal Entity Identifier Foundation [@GLEIF]. An ISO standard for vLEIs currently is under development at the International Organization for Standardization (ISO).  ACDCs are dependent on a suite of related specifications along with the KERI [@KERI_ID][@KERI] specification. These include CESR [@CESR_ID], SAID [@SAID_ID], did:keri [@DIDK_ID], and OOBI [@OOBI_ID]. Some of the major distinguishing features of ACDCs include normative support for chaining, use of composable JSON Schema [@JSch][@JSchCp], multiple serialization formats, namely, JSON [@JSON][@RFC4627], CBOR [@CBOR][@RFC8949], MGPK [@MGPK], and CESR [@CESR_ID], support for Ricardian contracts [@RC],  support for chain-link confidentiality [@CLC], a well-defined security model derived from KERI [@KERI][@KERI_ID],Compact formats for resource constrained applications, simple Partial disclosure mechanisms and simple Selective disclosure mechanisms. ACDCs provision data using a synergy of provenance, protection, and performance.


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

Chains of ACDCs that merely provide proof-of-authorship (authenticity) of data may be appended to chains of ACDCs that provide proof-of-authority (delegation) to enable verifiable delegated authorized authorship of data.  This is also a vital facility for authentic data supply chains. Furthermore, any physical supply chain may be measured, monitored, regulated, audited, and/or archived by a data supply chain acting as a digital twin [@Twin]. Therefore, ACDCs provide the critical enabling facility for an authentic data economy and, by association, an authentic real (twinned) economy.

ACDCs act as securely attributed (authentic) fragments of a distributed property graph (PG) [@PGM][@Dots]. Thus, ACDCs may be used to construct knowledge graphs expressed as property graphs [@KG]. ACDCs enable securely-attributed and privacy-protecting knowledge graphs. Semantically modulated verifiable provenanceable graphs enable authenticatable, delegable, attenuable, and aggregable authorizations and attributions.

The ACDC specification (including its disclosure mechanisms) leverages two primary cryptographic operations, namely digests and digital signatures [@Hash][@DSig]. These operations, when used in an ACDC, must have a security level, cryptographic strength, or entropy of approximately 128 bits [@Level]. (See the Annex A for a discussion of cryptographic strength and security)

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
Information theoretic security [@ITPS] The highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key).
Perfect security – a special case of Information theoretic security [@ITPS]
One-time-pad (OTP)(also called a Vernum Cipher OTP) [@VCphr]
Secret splitting [@SSplt] a type of secret sharing [@SShr] that uses the same technique as an OTP.

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/36
:::

Selective disclosure
Graduated disclosure
Partial disclosure
Full disclosure
Contractually protected disclosure
Chain-link confidential disclosure
Discloser/Disclosee
Issuer/Issuee
Controller
Verifier
Validator
Key state
Rotation/Rotation event
Interaction event
Inception event
Verifiable data registry
Duplicity
Attribute 
Targeted (Issueed) and Untargeted (Unissueed) ACDCs
Operator
Weight


TBD

Permissioned correlation
Percolated discovery
Rules 
Edge
Schema

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

An ACDC may be modeled abstractly as a nested `key: value` mapping. To avoid confusion with the cryptographic use of the term key,  the term field is used instead to refer to a mapping pair and the terms field label and field value for each member of a pair. These pairs can be represented by two tuples e.g., `(label, value)`. This terminology can be qualified, when necessary, by using the term field map to reference such a mapping. Field maps may be nested where a given field value is itself a reference to another field map. A nested set of fields is called a nested field map or simply a nested map for short. 

A field may be represented by a Framing code or block delimited serialization.  In a block delimited serialization, such as JSON, each field map is represented by an object block with block delimiters such as `{}` [@RFC8259][@JSON][@RFC4627]. Given this equivalence, the term block or nested block also may be used as synonymous with field map or nested field map. In many programming languages, a field map is implemented as a dictionary or hash table in order to enable performant asynchronous lookup of a field value from its field label. Reproducible serialization of field maps requires a canonical ordering of those fields. One such canonical ordering is called insertion or field creation order. A list of `(field, value)` pairs provides an ordered representation of any field map. Most programming languages now support ordered dictionaries or hash tables that provide reproducible iteration over a list of ordered field `(label, value)` pairs where the ordering is the insertion or field creation order. This enables reproducible round-trip serialization/deserialization of field maps.  ACDCs depend on insertion ordered field maps for canonical serialization/deserialization. ACDCs support multiple serialization types, namely JSON, CBOR, MGPK, and CESR but for the sake of simplicity, JSON only will be used for examples [@RFC8259][@JSON]. The basic set of normative field labels in ACDC field maps is defined in the following table.

### Field label tables

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/13
:::

### Top-Level fields

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/12
:::

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: ACDCvvSSSShhhhhh_ that provides protocol type, version, serialization type, size, and terminator. |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Issuer Identifier (AID)| Autonomic Identifier whose control authority is established via KERI verifiable key state. |
|`ri`| Registry Identifier | Issuance and/or revoation, transfer, or retraction registry for ACDC derived from Issuer identifier. |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of edges or the block itself.|
|`r`| Rule | Either the SAID a block of rules or the block itself. |


### Other fields

These may appear at other levels besides the top-level of an ACDC but are nonetheless reserved.

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

The version string field here follows the Composable Event Streaming Representation (CESR) specification for versionstring fields.

The version string, `v`, field must be the first field in any top-level ACDC field map. The string provides a regular expression target for determining the serialization format and size (character count) of a serialized ACDC. A stream-parser may use the version string to extract and deserialize (deterministically) any serialized ACDC in a stream of serialized ACDCs. Each ACDC in a stream may use a different serialization type.

The format of the version string is `ACDCvvSSSShhhhhh_`. The first four characters `ACDC` indicate the enclosing field map serialization. The next two characters, `vv` provide the lowercase hexadecimal notation for the major and minor version numbers of the version of the ACDC specification used for the serialization. The first `v` provides the major version number and the second `v` provides the minor version number. For example, `01` indicates major version 0 and minor version 1 or in dotted-decimal notation `0.1`. Likewise, `1c` indicates major version 1 and minor version decimal 12 or in dotted-decimal notation `1.12`. The next four characters `SSSS` indicate the serialization type in uppercase. The four supported serialization types are `JSON`, `CBOR`, `MGPK`, and `CESR` for the JSON, CBOR, MessagePack, and CESR serialization standards respectively [@JSON][@RFC4627][@CBOR][@RFC8949][@MGPK][@CESR_ID]. 

The next six characters provide in lowercase hexadecimal notation the total number of characters in the serialization of the ACDC. The maximum length of a given ACDC thereby is constrained to be 2<sup>24</sup> = 16,777,216 characters in length. The final character `-` is the version string terminator. This enables later versions of ACDC to change the total version string size and thereby enable versioned changes to the composition of the fields in the version string while preserving deterministic regular expression extractability of the version string. 

Although a given ACDC serialization type may have a field map delimiter or framing code characters that appear before (i.e., prefix) the version string field in a serialization, the set of possible prefixes is sufficiently constrained by the allowed serialization protocols to guarantee that a regular expression can determine unambiguously the start of any ordered field map serialization that includes the version string as the first field value. Given the version string, a parser then may determine the end of the serialization so that it can extract the full ACDC from the stream without first deserializing it. This enables performant stream parsing and off-loading of ACDC streams that include any or all of the supported serialization types.

### Self-addressing identifier (SAID) fields

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/14
:::

Some fields in ACDCs may have for their value either a field map or a SAID. A SAID follows the SAID protocol [@SAID_ID]. Essentially a SAID is a Self-addressing identifier (self-referential content addressable). A SAID is a special type of cryptographic digest of its encapsulating field map (block). The encapsulating block of a SAID is called a SAD (Self-addressed data). Using a SAID as a field value enables a more compact but secure representation of the associated block (SAD) from which the SAID is derived. Any nested field map that includes a SAID field (i.e., is, therefore, a SAD) may be compacted into its SAID. The uncompacted blocks for each associated SAID may be attached or cached to optimize bandwidth and availability without decreasing security.

Several top-level ACDC fields may have for their value either a serialized field map or the SAID of that field map. Each SAID provides a stable universal cryptographically verifiable and agile reference to its encapsulating block (serialized field map). Specifically, the value of top-level `s`, `a`, `e`, and `r` fields may be replaced by the SAID of their associated field map. When replaced by their SAID, these top-level sections are in compact form.

Recall that a cryptographic commitment (such as a digital signature or cryptographic digest) on a given digest with sufficient cryptographic strength including collision resistance [@HCR][@QCHC] is equivalent to a commitment to the block from which the given digest was derived.  Specifically, a digital signature on a SAID makes a verifiable cryptographic non-repudiable commitment that is equivalent to a commitment on the full serialization of the associated block from which the SAID was derived. This enables reasoning about ACDCs in whole or in part via their SAIDS in a fully interoperable, verifiable, compact, and secure manner. This also supports the well-known bow-tie model of Ricardian Contracts [@RC]. This includes reasoning about the whole ACDC given by its top-level SAID, `d`, field as well as reasoning about any nested sections using their SAIDS.

### Universally unique identifier (UUID) fields

The purpose of the UUID, `u`, field in any block is to provide sufficient entropy to the SAID, `d`, field of the associated block to make computationally infeasible any brute force attacks on that block that attempt to discover the block contents from the schema and the SAID. The UUID, `u`, field may be considered a salty nonce [@Salt]. Without the entropy provided the UUID, `u`, field, an adversary may be able to reconstruct the block contents merely from the SAID of the block and the schema of the block using a rainbow or dictionary attack on the set of field values allowed by the schema [@RB][@DRB]. The effective security level, entropy, or cryptographic strength of the schema-compliant field values may be much less than the cryptographic strength of the SAID digest. Another way of saying this is that the cardinality of the power set of all combinations of allowed field values may be much less than the cryptographic strength of the SAID. Thus, an adversary could successfully discover via brute force the exact block by creating digests of all the elements of the power set which may be small enough to be computationally feasible instead of inverting the SAID itself. Sufficient entropy in the `u` field ensures that the cardinality of the power set allowed by the schema is at least as great as the entropy of the SAID digest algorithm itself.

A UUID, `u` field may optionally appear in any block (field map) at any level of an ACDC. Whenever a block in an ACDC includes a UUID, `u`, field then its associated SAID, `d`, field makes a blinded commitment to the contents of that block. The UUID, `u`, field is the blinding factor. This makes that block securely partially disclosable or even selectively disclosable notwithstanding disclosure of the associated schema of the block. The block contents can only be discovered given disclosure of the included UUID field. Likewise, when a UUID, `u`, field appears at the top level of an ACDC then that top-level SAID, `d`, field makes a blinded commitment to the contents of the whole ACDC itself. Thus, the whole ACDC, not merely some block within the ACDC, may be disclosed in a privacy-preserving (correlation minimizing) 

### Autonomic identifier (AID) and Derived identifier fields

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/15
:::

Some fields, such as the `i`, Issuer identifier field, must each have an AID as its value. An AID is a fully qualified Self-certifying Identifier (SCID) that follows the KERI protocol [@KERI][@KERI_ID]. A related type of identifier field is the `ri`, registry identifier field. The `ri` field is cryptographically derived from the Issuer identifier field value so has securely attributable control authority via the AID from which it is derived.  A SCID is derived from one or more `(public, private)` key pairs using asymmetric or public-key cryptography to create verifiable digital signatures [@DSig]. Each AID has a set of one or more Controllers who each control a private key. By virtue of their private key(s), the set of Controllers may make statements on behalf of the associated AID that is backed by uniquely verifiable commitments via digital signatures on those statements. Any entity then may verify those signatures using the associated set of public keys. No shared or trusted relationship between the Controllers and Verifiers is required. The verifiable key state for AIDs is established with the KERI protocol [@KERI][@KERI_ID]. The use of AIDS enables ACDCs to be used in a portable but securely attributable, fully decentralized manner in an ecosystem that spans trust domains.

### Namespaced AIDs

Because KERI is agnostic about the namespace for any particular AID, different namespace standards may be used to express KERI AIDs or identifiers derived from AIDs as the value of these AID related fields in an ACDC. The examples below use the W3C DID namespace specification with the `did:keri` method [@DIDK_ID]. But the examples would have the same validity from a KERI perspective if some other supported namespace was used or no namespace was used at all. The latter case consists of a bare KERI AID (identifier prefix) expressed in CESR format [@CESR_ID].


### Selectively disclosable attribute aggregate field

The top-level selectively disclosable attribute aggregate section, `A`, field value is an aggregate of cryptographic commitments used to make a commitment to a set (bundle) of selectively disclosable attributes. The value of the attribute aggregate, `A`, field depends on the type of Selective disclosure mechanism employed. For example, the aggregate value could be the cryptographic digest of the concatenation of an ordered set of cryptographic digests, a Merkle tree root digest of an ordered set of cryptographic digests, or a cryptographic accumulator. The different Selective disclosure mechanisms are described in detail in the Selective disclosure section. 

### Field ordering

The ordering of the top-level fields when present in an ACDC must be as follows, `v`, `d`, `u`, `i`, `ri`, `s`, `a`, `e`, `r`.



## ACDC variants

There are several variants of ACDCs determined by the presence/absence of certain fields and/or the value of those fields when used in combination. The primary ACDC variants are public, private, metadata, and bespoke. A given variant may be targeted (untargeted). 

All the variants have two alternate forms, compact and non-compact. In the compact form of any variant, the values of the top-level fields for the attribute, attribute aggregate, schema, edge, and rule sections are the SAIDs (digests) of the corresponding expanded (non-compact) form of each section {{SAID}}. Additional variants arise from the presence or absence of different fields inside the attribute or attribute aggregate section. For example, a given variant may be either targeted or untargeted based on the presence of the Issuee field in the attribute or attribute aggreate sections. Similarly, any variant with an attribute section may have nested sub-blocks within the attribute section that are either compact or non-compact. The type of disclosure a given variant provides may be dependent on how the different sections appear in the ACDC.
The details of each variant are explained below.


#### Compact ACDC
The top-level section field values of a Compact ACDC are the SAIDs of each uncompacted top-level section. The section field labels
are `s`, `a`, `e`, and `r`.


  At the top level, the presence (absence), of the UUID, `u`, field produces two variants. These are private (public) respectively. In addition, a present but empty UUID, `u`, field produces a private metadata variant.

#### Compact public ACDC

An example of a fully compact public ACDC is shown below.

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "ri": "did:keri:EymRy7xMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggt",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "ERH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOA",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

#### Compact private ACDC  

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/22
:::

An example of a fully compact private ACDC is shown below.

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "u":  "0ANghkDaG7OY1wjaDAE0qHcg",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "ri": "did:keri:EymRy7xMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggt",
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
  "type": "object",
  "required":
  [
    "v",
    "d",
    "u",
    "i",
    "ri",
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
    "ri":
    {
      "description": "credential status registry ID",
      "type": "string"
    },
    "s": {
      "description": "schema SAID",
      "type": "string"
    },
    "a": {
      "description": "attribute SAID",
      "type": "string"
    },
    "e": {
      "description": "edge SAID",
      "type": "string"
    },
    "r": {
      "description": "rule SAID",
      "type": "string"
    }
  },
  "additionalProperties": false
}
```


### Public ACDC

Given that there is no top-level UUID, `u`, field in an ACDC, then knowledge of both the schema of the ACDC and the top-level SAID, `d`, field may enable the discovery of the remaining contents of the ACDC via a rainbow table attack [@RB][@DRB]. Therefore, although the top-level, `d`, field is a cryptographic digest, it may not securely blind the contents of the ACDC when knowledge of the schema is available.  The field values may be discoverable. Consequently, any cryptographic commitment to the top-level SAID, `d`, field may provide a fixed point of correlation potentially to the ACDC field values themselves in spite of non-disclosure of those field values. Thus, an ACDC without a top-level UUID, `u`, field must be considered a public (non-confidential) ACDC.

### Private ACDC

Given a top-level UUID, `u`, field, whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of an ACDC may provide a secure cryptographic digest that blinds the contents of the ACDC [@Hash]. An adversary when given both the schema of the ACDC and the top-level SAID, `d`, field, is not able to discover the remaining contents of the ACDC in a computationally feasible manner such as through a rainbow table attack [@RB][@DRB]. Therefore, the top-level, UUID, `u`, field may be used to securely blind the contents of the ACDC notwithstanding knowledge of the schema and top-level, SAID, `d`, field.  Moreover, a cryptographic commitment to that that top-level SAID, `d`, field does not provide a fixed point of correlation to the other ACDC field values themselves unless and until there has been a disclosure of those field values. Thus, an ACDC with a sufficiently high entropy top-level UUID, `u`, field may be considered a private (confidential) ACDC. enables a verifiable commitment to the top-level SAID of a private ACDC to be made prior to the disclosure of the details of the ACDC itself without leaking those contents. This is called Partial disclosure. Furthermore, the inclusion of a UUID, `u`, field in a block also enables Selective disclosure mechanisms described later in the section on Selective disclosure.

### Metadata ACDC 

An empty, top-level UUID, `u`, field appearing in an ACDC indicates that the ACDC is a metadata ACDC. The purpose of a metadata ACDC is to provide a mechanism for a Discloser to make cryptographic commitments to the metadata of a yet to be disclosed private ACDC without providing any point of correlation to the actual top-level SAID, `d`, field of that yet to be disclosed ACDC. The top-level SAID, `d`, field, of the metadata ACDC, is cryptographically derived from an ACDC with an empty top-level UUID, `u`, field so its value will necessarily be different from that of an ACDC with a high entropy top-level UUID, `u`, field value. Nonetheless, the Discloser may make a non-repudiable cryptographic commitment to the metadata SAID in order to initiate a Chain-link confidentiality exchange without leaking correlation to the actual ACDC to be disclosed [@CLC]. A Disclosee may verify the other metadata information in the metadata ACDC before agreeing to any restrictions imposed by the future disclosure. The metadata includes the Issuer, the schema, the provenancing edges, and the rules (terms-of-use). The top-level attribute section, `a`, field value of a metadata ACDC may be empty so that its value is not correlatable across disclosures (presentations). Should the potential Disclosee refuse to agree to the rules, then the Discloser has not leaked the SAID of the actual ACDC or the SAID of the Attribute block that would have been disclosed.

Given the metadata ACDC, the potential Disclosee is able to verify the Issuer, the schema, the provenanced edges, and rules prior to agreeing to the rules.  Similarly, an Issuer may use a metadata ACDC to get agreement to a contractual waiver expressed in the rule section with a potential Issuee prior to issuance. Should the Issuee refuse to accept the terms of the waiver, then the Issuer has not leaked the SAID of the actual ACDC that would have been issued nor the SAID of its attributes block nor the attribute values themselves.

When a metadata ACDC is disclosed (presented) only the Discloser's signature(s) is attached, not the Issuer's signature(s). This precludes the Issuer's signature(s) from being used as a point of correlation until after the Disclosee has agreed to the terms in the rule section. When Chain-link confidentiality is used, the Issuer's signature(s) are not disclosed to the Disclosee until after the Disclosee has agreed to keep them confidential. The Disclosee is protected from a forged Discloser because ultimately verification of the disclosed ACDC will fail if the Discloser does not eventually provide verifiable Issuer's signatures. Nonetheless, should the potential Disclosee not agree to the terms of the disclosure expressed in the rule section, then the Issuer's signature(s) is not leaked.

## Top-level ACDC sections


## Schema 

### Type-is-schema

Notable is the fact that there are no top-level type fields in an ACDC. This is because the schema, `s`, field itself is the type field for the ACDC and its parts. ACDCs follow the design principle of separation of concerns between a data container's actual payload information and the type information of that container's payload. In this sense, type information is metadata, not data. The schema dialect used by ACDCs is JSON Schema 2020-12 [@JSch][@JSch_202012]. JSON Schema supports composable schema (sub-schema), conditional schema (sub-schema), and regular expressions in the schema. Composability enables a Validator to ask and answer complex questions about the type of even optional payload elements while maintaining isolation between payload information and type (structure) information about the payload [@JSchCp][@JSchRE][@JSchId][@JSchCx]. A static but composed schema allows a verifiably immutable set of variants. Although the set is immutable, the variants enable graduated but secure disclosure. ACDC's use of JSON Schema must be in accordance with the ACDC defined profile as defined herein. The exceptions are defined below.

### Schema ID field label

The usual field label for SAID fields in ACDCs is `d`. In the case of the schema section, however, the field label for the SAID of the schema section is `$id`. This repurposes the schema id field label, `$id` as defined by JSON Schema [@JSchId][@JSchCx].  The top-level id, `$id`, field value in a JSON Schema provides a unique identifier of the schema instance. In a non-ACDC schema, the value of the id, `$id`, field is expressed as a URI. This is called the Base URI of the schema. In an ACDC schema, however, the top-level id, `$id`, field value is repurposed. This field value must include the SAID of the schema. This ensures that the ACDC schema is static and verifiable to their SAIDS. A verifiably static schema satisfies one of the essential security properties of ACDCs as discussed below. There are several ACDC supported formats for the value of the top-level id, `$id`, field but all of the formats must include the SAID of the schema (see below). Correspondingly, the value of the top-level schema, `s`, field must be the SAID included in the schema's top-level `$id` field. The detailed schema is either attached or cached and maybe discovered via its SAIDified, id, `$id`, field value.

The digest algorithm employed for generating schema SAIDS shall have an approximate cryptographic strength of 128 bits. The SAID MUST be generated in compliance with the ToIP SAID internet draft specification and MUST be encoded using CESR. The CESR encoding indicates the type of cryptographic digest used to generate the SAID. 


When an id, '$id', field appears in a sub-schema, it indicates a bundled sub-schema called a schema resource [@JSchId][@JSchCx]. The value of the id, '$id', field in any ACDC bundled sub-schema resource must include the SAID of that sub-schema using one of the formats described below. The sub-schema so bundled must be verifiable against its referenced and embedded SAID value. This ensures secure bundling.

### Static (immutable) schema

For security reasons, the full schema of an ACDC must be completely self-contained and statically fixed (immutable) for that ACDC meaning that no dynamic schema references or dynamic schema generation mechanisms are allowed.

Should an adversary successfully attack the source that provides the dynamic schema resource and change the result provided by that reference, then the schema validation on any ACDC that uses that dynamic schema reference may fail. Such an attack effectively revokes all the ACDCs that use that dynamic schema reference, which is called a schema revocation attack.

More insidiously, an attacker could shift the semantics of the dynamic schema in such a way that although the ACDC still passes its schema validation, the behavior of the downstream processing of that ACDC is changed by the semantic shift. This type of attack is called a semantic malleability attack which may be considered a new type of transaction malleability attack [@TMal].

To prevent both forms of attack, all schema must be static, i.e., schema must be SADs and therefore verifiable against their SAIDs.

To elaborate, the serialization of a static schema may be self-contained. A compact commitment to the detailed static schema may be provided by its SAID. In other words, the SAID of a static schema is a verifiable cryptographic identifier for its SAD. Therefore, all ACDC compliant schema must be SADs. In other words, the schema must therefore be SAIDified. The associated detailed static schema (uncompacted SAD) is bound cryptographically and verifiable to its SAID.

The JSON Schema specification allows complex schema references that may include non-local URI references [@JSchId][@JSchCx][@RFC3986][@RFC8820]. These references may use the `$id` or `$ref` keywords. A relative URI reference provided by a `$ref` keyword is resolved against the Base URI provided by the top-level `$id` field. When this top-level Base URI is non-local, then all relative `$ref` references are therefore also non-local. A non-local URI reference provided by a `$ref` keyword may be resolved without reference to the Base URI.

In general, schema indicated by non-local URI references (`$id` or `$ref`) must not be used because they are not cryptographically end-verifiable. The value of the underlying schema resource so referenced may change (mutate). To restate, a non-local URI schema resource is not end-verifiable to its URI reference because there is no cryptographic binding between URI and resource [@RFC3986][@RFC8820].

This does not preclude the use of remotely cached SAIDified schema resources because those resources are end-verifiable to their embedded SAID references. Said another way, a SAIDified schema resource is itself a SAD  referenced by its SAID. A URI that includes a SAID may be used to securely reference a remote or distributed SAIDified schema resource because that resource is fixed (immutable, nonmalleable) and verifiable to both the SAID in the reference and the embedded SAID in the resource so referenced. To elaborate, a non-local URI reference that includes an embedded cryptographic commitment such as a SAID is verifiable to the underlying resource when that resource is a SAD. This applies to JSON Schema as a whole as well as bundled sub-schema resources.

There ACDC supported formats for the value of the top-level id, `$id`, field are as follows:

Bare SAIDs may be used to refer to a SAIDified schema as long as the JSON schema validator supports bare SAID references. By default, many if not all JSON schema validators support bare strings (non-URIs) for the Base URI provided by the top-level `$id` field value.

-	The `sad:` URI scheme may be used to directly indicate a URI resource thatsafely returns a verifiable SAD. For example, `sad:SAID` where SAID* is replaced with the actual SAID of a SAD that provides a verifiable non-local reference to JSON Schema as indicated by the mime-type of `schema+json`.

-	The KERI OOBI draft specification provides a URL syntax that references a SAD resource by its SAID at the service endpoint indicated by that URL [@OOBI_ID]. Such remote OOBI URLs are also safe because the provided SAD resource is verifiable against the SAID in the OOBI URL. Therefore, OOBI URLs are also acceptable non-local URI references for JSON Schema [@OOBI_ID][@RFC3986][@RFC8820].

-	The `did:` URI scheme may be used safely to prefix non-local URI references that act to namespace SAIDs expressed as DID URIs or DID URLs.  DID resolvers resolve DID URLs for a given DID method such as `did:keri` [@DIDK_ID] and may return DID docs or DID doc metadata with SAIDified schema or service endpoints that return SAIDified schema or OOBIs that return SAIDified schema [@RFC3986][@RFC8820][@OOBI_ID]. A verifiable non-local reference in the form of DID URL that includes the schema SAID is resolved safely when it dereferences to the SAD of that SAID. For example, the resolution result returns an ACDC JSON Schema whose id, `$id`, field includes the SAID and returns a resource with JSON Schema mime-type of `schema+json`.


To clarify, ACDCs must not use complex JSON Schema references which allow dynamically generated schema resources to be obtained from online JSON Schema Libraries [@JSchId][@JSchCx]. The latter approach may be difficult or impossible to secure because a cryptographic commitment to the base schema that includes complex schema (non-relative URI-based) references only commits to the non-relative URI reference and not to the actual schema resource which may change (is dynamic, mutable, malleable). To restate, this approach is insecure because a cryptographic commitment to a complex (non-relative URI-based) reference is not equivalent to a commitment to the detailed associated schema resource so referenced if it may change.

ACDCs must use static JSON Schema (i.e., SAIDifiable schema). These may include internal relative references to other parts of a fully self-contained static (SAIDified) schema or references to static (SAIDified) external schema parts. As indicated above, these references may be bare SAIDs, DID URIs or URLs (`did:` scheme), SAD URIs (`sad:` scheme), or OOBI URLs [@OOBI_ID]. Recall that a commitment to a SAID with sufficient collision resistance makes an equivalent secure commitment to its encapsulating block SAD. Thus, static schema may be either fully self-contained or distributed in parts but the value of any reference to a part must be verifiably static (immutable, nonmalleable) by virtue of either being relative to the self-contained whole or being referenced by its SAID. The static schema in whole or in parts may be attached to the ACDC itself or provided via a highly available cache or data store. To restate, this approach is securely end-verifiable (zero-trust) because a cryptographic commitment to the SAID of a SAIDified schema is equivalent to a commitment to the detailed associated schema itself (SAD).

### Schema dialect

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/18
:::

The Schema dialect for ACDC 1.0 is JSON Schema 2020-12 and is indicated by the identifier `"https://json-schema.org/draft/2020-12/schema"`  [@JSch][@JSch_202012]. This is indicated in a JSON Schema via the value of the top-level `$schema` field. Although the value of `$schema` is expressed as a URI, de-referencing does not provide dynamically downloadable schema dialect validation code. This would be an attack vector. The Validator must control the tooling code dialect used for schema validation and hence the tooling dialect version actually used. A mismatch between the supported tooling code dialect version and the `$schema` string value should cause the validation to fail. The string is simply an identifier that communicates the intended dialect to be processed by the schema validation tool. When provided, the top-level `$schema` field value for ACDC version 1.0 must be "https://json-schema.org/draft/2020-12/schema".

### Schema versioning

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/20
:::

Each schema shall have at the top level version field with field label `version`. The value of the `version` field shall be a semantic version string in the dotted decimal notation of the form "major.minor.path" . For example, "1.2.3" has a major version number of 1, a minor version number of 2, and a patch version of 3. This value is informative. The `version` field value is not used in the JSON Schema validation against the ACDC. Therefore, a given ACDC may properly pass JSON Schema validation process regardless of the value of its schema `version` field.  

{{Semantic Versioning Specification 2.0 https://semver.org}}


Recall that the value of the Schema ID, `$id` field in an ACDC schema is a SAID which provides an encoded agile cryptographic digest of the contents of the schema. Any change to the schema, including a change to its `version` field, results in a new SAID. Any copy of a schema that verifies against the same SAID given by the Schema ID, `$id` field value can be assumed to be identical to any other copy that verifies to the same SAID by virtue of the strong collision resistance of the digest employed.

This gives rise to two meanings of the word "version" when applied to an ACDC's schema. One is the version given by the value of its `$id` field, and the other is the version given by its `version` field. The version provided by the `$id` field is cryptographically verifiable. Whereas the version provided by the `version` field is not. Thus, the latter is an informative indication of the version, and the former is a normative determiner of the version. In this sense, the schema ID, `$id` field value as a SAID provides a cryptographically verifiable version indicator independent of the version field value. To avoid confusion, any change to the schema that changes the value of the `$id` shall also be reflected in a correspondingly unique value of its `version` field. Business logic may depend on consistency between the `version` field value with respect to the `$id` field value. Notwithstanding the actual value of the `version` field, the `$id` field value is the normative determiner of the schema's true, verifiable version.

The JSON schema for an ACDC may use composition operators (see below). This allows extensibility in schema such that, in some cases, ACDCs with newer schema versions may be backward (im)compatible with older schema versions. A new schema version, as given by the `$id` field value, is considered backward incompatible with respect to a previous version of a schema when any instance of an ACDC that validates (in the JSON Schema sense of validation) against the previous version of the schema may not be guaranteed to validate against the new version. Because any change to the `version` field value results in a different `$id` field value, the backward compatibility rule also applies changes in the `version` field value. To comply with the semantic versioning rules, a backward incompatible schema shall have a higher major version number in its `version` field value than any backward incompatible version.


### Schema availability

The composed detailed (uncompacted) (bundled) static schema for an ACDC may be cached or attached. But cached, and/or attached static schema is not to be confused with dynamic schema. Nonetheless, while securely verifiable, a remotely cached, SAIDified, schema resource may be unavailable. Availability is a separate concern. Unavailable does not mean insecure or unverifiable. ACDCs must be verifiable when available.  Availability is typically solvable through redundancy. Although a given ACDC application domain or ecosystem governance framework may impose schema availability constraints, this ACDC specification itself does not impose any specific availability requirements on Issuers other than schema caches should be sufficiently available for the intended application of their associated ACDCs. It is up to the Issuer of an ACDC to satisfy any availability constraints on its schema that may be imposed by the application domain or ecosystem.

### Composable JSON Schema

A composable JSON Schema enables the use of any combination of compacted/uncompacted attribute, edge, and rule sections in a provided ACDC. When compact, any one of these sections may be represented merely by its SAID [@JSch][@JSchCp]. When used for the top-level attribute, `a`, edge, `e`, or rule, `r`, section field values, the `oneOf` sub-schema composition operator provides both compact and uncompacted variants. The provided ACDC must validate against an allowed combination of the composed variants, either the compact SAID of a block or the full detailed (uncompacted) block for each section. The Validator determines what decomposed variants the provided ACDC must also validate against. Decomposed variants may be dependent on the type of Graduated disclosure, Partial,selective or full disclosure. Essentially, a composable schema is a verifiable bundle of metadata (composed) about content that then can be verifiably unbundled (decomposed) later. The Issuer makes a single verifiable commitment to the bundle (composed schema) and a recipient may then safely unbundle (decompose) the schema to validate any of the Graduated disclosures variants allowed by the composition.

Unlike the other compactifiable sections, it is impossible to define recursively the exact detailed schema as a variant of a `oneOf` composition operator contained in itself. Nonetheless, the provided schema, whether self-contained, attached, or cached must validate as a SAD against its provided SAID. It also must validate against one of its specified `oneOf` variants.

The compliance of the provided non-schema attribute, `a`, edge, `e`, and rule, `r`, sections must be enforced by validating against the composed schema. In contrast, the compliance of the provided composed schema for an expected ACDC type must be enforced by the Validator. This is because it is not possible to enforce strict compliance of the schema by validating it against itself.

ACDC specific schema compliance requirements usually are specified in the ecosystem governance framework (EGF) for a given ACDC type.  Because the SAID of a schema is a unique content-addressable identifier of the schema itself, compliance can be enforced by comparison to the allowed schema SAID in a well-known publication or registry of ACDC types for a EGF. The EGF may be specified solely by the Issuer for the ACDCs it generates or be specified by some mutually agreed upon ecosystem governance mechanism. Typically, the business logic for making a decision about a presentation of an ACDC starts by specifying the SAID of the composed schema for the ACDC type that the business logic is expecting from the presentation. The verified SAID of the actually presented schema is then compared against the expected SAID. If they match, then the actually presented ACDC may be validated against any desired decomposition of the expected (composed) schema.

To elaborate, a Validator can confirm compliance of any non-schema section of the ACDC against its schema both before and after uncompacted disclosure of that section by using a composed base schema with `oneOf` pre-disclosure and a decomposed schema post-disclosure with the compact `oneOf` option removed. This capability provides a mechanism for secure schema validation of both Compact and uncompacted variants that require the Issuer to only commit to the composed schema and not to all the different schema variants for each combination of a given compact/uncompacted section in an ACDC.

One of the most important features of ACDCs is support for Chain-link confidentiality [@CLC]. This provides a powerful mechanism for protecting against unpermissioned exploitation of the data disclosed via an ACDC. Essentially, an exchange of information compatible with Chain-link confidentiality starts with an offer by the Discloser to disclose confidential information to a potential Disclosee. This offer includes sufficient metadata about the information to be disclosed such that the Disclosee can agree to those terms. Specifically, the metadata includes both the schema of the information to be disclosed and the terms of use of that data once disclosed. Once the Disclosee has accepted the terms, then Full disclosure is made. A full disclosure that happens after contractual acceptance of the terms of use is called permissioned disclosure. The pre-acceptance disclosure of metadata is a form of Partial disclosure.

As is the case for Compact (uncompacted) ACDC disclosure, composable JSON schema, enables the use of the same base schema for both the validation of the Partial disclosure of the offer metadata prior to contract acceptance and validation of full or detailed disclosure after contract acceptance [@JSch][@JSchCp]. A cryptographic commitment to the base schema securely specifies the allowable semantics for both Partial and Full disclosure. Decomposition of the base schema enables a Validator to impose more specific semantics at later stages of the exchange process. Specifically, the `oneOf` sub-schema composition operator validates against either the compact SAID of a block or the full block. Decomposing the schema to remove the optional Compact variant enables a Validator to ensure complaint Full disclosure. To clarify, a Validator can confirm schema compliance both before and after detailed disclosure by using a composed base schema pre-disclosure and a decomposed schema post-disclosure with the undisclosed options removed. These features provide a mechanism for secure schema-validated contractually-bound Partial (and/or Selective) disclosure of confidential data via ACDCs.

### Attribute section

The Attribute section in the examples above has been compacted into its SAID. The schema of the compacted Attribute section is as follows,

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

Two variants of an ACDC, namely, namely, private (public) attribute are defined respectively by the presence (absence) of a UUID, `u`, field in the uncompacted Attribute section block.

Two other variants of an ACDC, namely, targeted (untargeted) are defined respectively by the presence (absence) of an Issuee, `i`, field in the uncompacted Attribute section block.

#### Public-attribute ACDCA
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

The SAID, `d`, field at the top level of the uncompacted attribute block is the same SAID used as the compacted value of the Attribute section, `a`, field.

Given the absence of a `u` field at the top level of the attributes block, then knowledge of both SAID, `d`, field at the top level of an attributes block and the schema of the attributes block may enable the discovery of the remaining contents of the attributes block via a rainbow table attack [@RB][@DRB]. Therefore, the SAID, `d`, field of the attributes block, although, a cryptographic digest, does not securely blind the contents of the attributes block given knowledge of the schema. It only provides compactness, not privacy. Moreover, any cryptographic commitment to that SAID, `d`, field provides a fixed point of correlation potentially to the attribute block field values themselves in spite of non-disclosure of those field values via a Compact ACDC. Thus, an ACDC without a UUID, `u`, field in its attributes block must be considered a public-attribute ACDC even when expressed in compact form.

#### Public uncompacted attribute section schema

The subschema for the public uncompacted Attribute section is shown below,

```json
{
  "a":
  {
    "description": "attribute section",
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
        "description": "attribute SAID",
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
}
```

#### Composed schema for both public compact and uncompacted attribute section variants

Through the use of the JSON Schema `oneOf` composition operator, the following composed schema will validate against both the Compact and un-compacted value of the Attribute section field.

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

#### Private-attribute ACDC

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

Given the presence of a top-level UUID, `u`, field of the attribute block whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of the attribute block provides a secure cryptographic digest of the contents of the attribute block [@Hash]. An adversary when given both the schema of the attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the attribute block in a computationally feasible manner such as a rainbow table attack [@RB][@DRB].  Therefore, the attribute block's UUID, `u`, field in a compact ACDC enables its attribute block's SAID, `d`, field to securely blind the contents of the attribute block notwithstanding knowledge of the attribute block's schema and SAID, `d` field.  Moreover, a cryptographic commitment to that attribute block's, SAID, d`, field does not provide a fixed point of correlation to the attribute field values themselves unless and until there has been a disclosure of those field values.

To elaborate, when an ACDC includes a sufficiently high entropy UUID, `u`, field at the top level of its attributes block then the ACDC may be considered a private-attributes ACDC when expressed in compact form, that is, the attribute block is represented by its SAID, `d`, field and the value of its top-level Attribute section, `a`, field is the value of the nested SAID, `d`, field from the uncompacted version of the attribute block. A verifiable commitment may be made to the compact form of the ACDC without leaking details of the attributes. Later disclosure of the uncompacted attribute block may be verified against its SAID, `d`, field that was provided in the compact form as the value of the top-level Attribute section, `a`, field.

Because the Issuee AID is nested in the attribute block as that block's top-level, Issuee, `i`, field, a presentation exchange (disclosure) could be initiated on behalf of a different AID that has not yet been correlated to the Issuee AID and then only correlated to the Issuee AID after the Disclosee has agreed to the Chain-link confidentiality provisions in the rules section of the private-attributes ACDC [@CLC].

#### Composed Schema for both compact and uncompacted private-attribute ACDCs

Through the use of the JSON Schema `oneOf` composition operator, the following composed schema will validate against both the compact and un-compacted value of the private-attribute section, `a`, field.


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

As described above in the Schema section of this specification, the `oneOf` sub-schema composition operator validates against either the compact SAID of a block or the full block. A Validator can use a composed schema that has been committed to by the Issuer to securely confirm schema compliance both before and after detailed disclosure by using the fully composed base schema pre-disclosure and a specific decomposed variant post-disclosure. Decomposing the schema to remove the optional compact variant (i.e., removing the `oneOf` compact option) enables a Validator to ensure compliant Full disclosure.


#### Untargeted ACDC

Consider the case where the Issuee, `i`, field is absent at the top level of the Attribute section as shown below:

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
This ACDC has an Issuer but no Issuee. Therefore, there is no provably controllable Target AID. This may be thought of as an undirected verifiable attestation or observation of the data in the Attributes section by the Issuer. One could say that the attestation is addressed to "whom it may concern" which is therefore an Untargeted ACDC, or equivalently an Unissueed ACDC. An untargeted ACDC enables verifiable authorship by the Issuer of the data in the Attributes section but there is no specified counterparty and no verifiable mechanism for delegation of authority.  Consequently, the rule section may provide only contractual obligations of implied counterparties.

This form of an ACDC provides a container for authentic data only (not authentic data as authorization). But authentic data is still a very important use case. To clarify, an Untargeted ACDC enables verifiable authorship of data. An observer such as a sensor that controls an AID may make verifiable non-repudiable measurements and publish them as ACDCs. These may be chained together to provide provenance for or a chain-of-custody of any data.  These ACDCs could be used to provide a verifiable data supply chain for any compliance-regulated application. This provides a way to protect participants in a supply chain from imposters. Such data supply chains are also useful as a verifiable digital twin of a physical supply chain [@Twin].

A hybrid chain of one or more targeted ACDCs ending in a chain of one or more untargeted ACDCs enables delegated authorized attestations at the tail of that chain. This may be very useful in many regulated supply chain applications such as verifiable authorized authentic datasheets for a given pharmaceutical.

#### Targeted ACDC 

When present at the top level of the Attribute section, the Issuee, `i`, field value provides the AID of the Issuee of the ACDC. This Issuee AID is a provably controllable identifier that serves as the Target AID. This makes the ACDC a Targeted ACDC or equivalently an Issueed ACDC. Targeted ACDCs may be used for many different purposes such as an authorization or a delegation directed at the Issuee AID, i.e., the Target. In other words, a targeted ACDC provides a container for authentic data that may also be used as some form of authorization such as a credential that is verifiably bound to the Issuee as targeted by the Issuer. Furthermore, by virtue of the targeted Issuee's provable control over its AID, the Targeted ACDC may be verifiably presented (disclosed) by the Controller of the Issuee AID.

For example, the definition of the term credential is evidence of authority, status, rights, entitlement to privileges, or the like. To elaborate, the presence of an attribute section top-level Issuee, `i`, field enables the ACDC to be used as a verifiable credential given by the Issuer to the Issuee.

One reason the Issuee, `i`, field is nested into the Attribute section, `a`, block is to enable the Issuee AID to be private or partially or selectively disclosable. The Issuee may also be called the Holder or Subject of the ACDC.  But here the more semantically precise albeit less common terms of Issuer and Issuee are used. The ACDC is issued from or by an Issuer and is issued to or for an Issuee. This precise terminology does not bias or color the role (function) that an Issuee plays in the use of an ACDC. What the presence of Issuee AID does provide is a mechanism for control of the subsequent use of the ACDC once it has been issued. To elaborate, because the Issuee, `i`, field value is an AID, by definition, there is a provable Controller of that AID. Therefore that Issuee Controller may make non-repudiable commitments via digital signatures on behalf of its AID.  Therefore, subsequent use of the ACDC by the Issuee may be securely attributed to the Issuee.

Importantly the presence of an Issuee, `i`, field enables the associated Issuee to make authoritative verifiable presentations or disclosures of the ACDC. A designated Issuee also better enables the initiation of presentation exchanges of the ACDC between that Issuee as Discloser and a Disclosee (Verifier).

In addition, because the Issuee is a specified counterparty the Issuer may engage in a contract with the Issuee that the Issuee agrees to by virtue of its non-repudiable signature on an offer of the ACDC prior to its issuance. This agreement may be a pre-condition to the issuance and thereby impose liability waivers or other terms of use on that Issuee.

Likewise, the presence of an Issuee, `i`, field, enables the Issuer to use the ACDC as a contractual vehicle for conveying an authorization to the Issuee.  This enables verifiable delegation chains of authority because the Issuee in one ACDC may become the Issuer in some other ACDC. Thereby, an Issuer may delegate authority to an Issuee who may then become a verifiably authorized Issuer that then delegates that authority (or an attenuation of that authority) to some other verifiably authorized Issuee and so forth.

### Edge section  

In the compact ACDC examples above, the edge section has been compacted into merely the SAID of that section. Suppose that the uncompacted value of the edge section denoted by the top-level edge, `e`, field is as follows,

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA"
    }
  }
}
```

The edge section's top-level SAID, `d`, field is the SAID of the edge block and is the same SAID used as the compacted value of the ACDC's top-level edge, `e`, field. Each edge in the edge section gets its own field with its own local label. The value of the field may be a sub-block or in the simplest case a string. In the example above, the edge label is `"boss"`. Note that each edge does NOT include a type field. The type of each edge is provided by the schema vis-a-vis the label of that edge. This is in accordance with the design principle of ACDCs that may be succinctly expressed as "type-is-schema". This approach varies somewhat from many property graphs which often do not have a schema [@PGM][@Dots][@KG]. Because ACDCs have a schema for other reasons, however, they leverage that schema to provide edge types with a cleaner separation of concerns. Notwithstanding, this separation, an edge sub-block may include a constraint on the type of the ACDC to which that edge points by including the SAID of the schema of the pointed-to ACDC as a property of that edge.

#### Edge sub-block reserved fields

A main distinguishing feature of a property graph (PG) is that both nodes and edges may have a set of properties [@PGM][@Dots][@KG]. These might include modifiers that influence how the connected node is to be combined or place a constraint on the allowed type(s) of connected nodes.

There several reserved field labels for edge sub-blocks. These are detailed in the table below. Each edge sub-block may have other non-reserved field labels as needed for a particular edge type.

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Optional, self-referential fully qualified cryptographic digest of enclosing edge map. |
|`u`| UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`s`| Schema| Optional SAID of the JSON Schema block of the far node ACDC. |
|`n`| Node| Required SAID of the far ACDC as the terminating point of a directed edge that connects the edge's encapsulating near ACDC to the specified far ACDC as a fragment of a distributed property graph (PG).|
|`o`| Operator| Optional as either a unary operator on edge or an m-ary operator on edge-group in edge section. Enables expression of the edge logic on edge subgraph.|
|`w`| Weight| Optional edge weight property that enables default property for directed weighted edges and operators that use weights.|


The node, `n`, field is required. The SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, and weight, `w`,  fields are optional. To clarify, each edge sub-block MUST have a node, `n`, field and  MAY have any combination of SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, or weight, `w`, fields.

##### SAID field

When present, the SAID, `d`, field must appear as the first field in the edge sub-block. When present, the value of the SAID, `d` field must be the SAID of its enclosing edge sub-block.

##### UUID field

A UUID, `u`, field must not appear unless there is also a SAID, `d` field. When present, the UUID, `u`, field must appear immediately after as the SAID, `d`, field in the edge sub-block. When present, the value of the UUID, `u` is a pseudorandom string with approximately 128 bits of cryptographic entropy. The UUID, `u`, field acts as a salty nonce to hide the values of the edge sub-block in spite of knowledge of the edge sub-blocks SAID, `d`, field and its, the edge's, actual near schema (not its far node schema field).

##### Node field 

When the edge sub-block does not include a SAID, `d`, field then the node, `n`, field must appear as the first field in the edge sub-block, i.e., following the SAID, `d`, field which is first. When the edge sub-block does include a SAID, `d`, field then the node, `n`, field must appear as the second field in the edge sub-block.

The value of the required node, `n`, field is the SAID of the ACDC to which the edge connects i.e., the node, `n`, field indicated, designates, references, or "points to" another ACDC. The edge is directed from the near node that is the ACDC in which the edge sub-block resides and is directed to the far node that is the ACDC indicated by the node, `n`, field of that edge sub-block. In order for the edge (chain) to be valid, the ACDC Validator must confirm that the SAID of the provided far ACDC matches the node, `n`, field value given in the edge sub-block in near ACDC and must confirm that the provided far ACDC satisfies its own schema.

##### Schema field

When present, the schema, `s` field must appear immediately following the node `n`, field in the edge sub-block. When present, the value of the schema, `s` field must be the SAID of the top-level schema, `s`, field of the ACDC indicated by the edge's far node, `n`, field. When the schema, `s`, field is present in an edge sub-block, in order for the edge (chain) to be valid, the ACDC Validator, after validating that the provided far ACDC indicated by the node, `n`, field satisfies its (the far ACDC's) own schema, must also confirm that the value of the edge's schema, `s`, field matches the SAID of the far ACDC's schema as indicated by its top-level schema, `s`, field.

The following example adds both SAID, `d`, and schema, `s`, fields (edge properties) to the edge sub-block.

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss":
    {
      "d": "E2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn9y",
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "s": "ELIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdYerzw"
    }
  }
}
```

##### Operator field 

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/23
:::

When present, the operator, `o` field must appear immediately following all of the SAID, `d`, node, `n`, or schema, `s`, fields in the edge sub-block. The function of the operator field is explained in a later section.

##### Weight field

When present, the weight, `w` field must appear immediately following all of the SAID, `d`, node, `n`, schema, `s`, or operator, `o`, fields in the edge sub-block. The function of the weight field is explained in a later section.

#### Globally distributed secure graph fragments 

Abstractly, an ACDC with one or more edges may be a fragment of a distributed property graph. However, the local label does not enable the direct unique global resolution of a given edge including its properties other than a trivial edge with only one property, its node, `n` field. To enable an edge with additional properties to be globally uniquely resolvable, that edge's block must have a SAID, `d`, field. Because a SAID is a cryptographic digest it will universally and uniquely identify an edge with a given set of properties [@Hash]. This allows ACDCs to be used as secure fragments of a globally distributed property graph (PG). This enables a property graph to serve as a global knowledge graph in a secure manner that crosses trust domains [@PGM][@Dots][@KG]. This is shown below.


```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss":
    {
      "d": "E9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn",
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "w": "high"
    }
  }
}
```

#### Compact edge

Given that an individual edge's property block includes a SAID, `d`, field then a compact representation of the edge's property block is provided by replacing it with its SAID. This may be useful for complex edges with many properties. This is called a compact edge. This is shown as follows,

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss": "E9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn"
  }
}
```

#### Simple compact edge

When an edge sub-block has only one field that is its node, `n`, field then the edge block may use an alternate simplified compact form where the labeled edge field value is the value of its node, `n`, field. The schema for that particular edge label, in this case, `"boss"`, will indicate that the edge value is a node SAID and not the edge sub-block SAID as would be the case for the normal compact form shown above. This alternate compact form is shown below.

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA"
  }
}
```

#### Private edge

Each edge's properties may be blinded by its SAID, `d`, field (i.e., be private) if its properties block includes a UUID, `u` field. As with UUID, `u`, fields used elsewhere in ACDC, if the UUID, `u`, field value has sufficient entropy then the values of the properties of its enclosing block are not discoverable in a computationally feasible manner merely given the schema for the edge block and its SAID, `d` field. This is called a private edge. When a private edge is provided in compact form then the edge detail is hidden and is partially disclosable. An uncompacted private edge is shown below.

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss":
    {
      "d": "E9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NHwY1lkFrn",
      "u":  "0AG7OY1wjaDAE0qHcgNghkDa",
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "w": "high"
    }
  }
}
```

When an edge points to a private ACDC, a Discloser may choose to use a metadata version of that private ACDC when presenting the node, `n`, field of that edge prior to acceptance of the terms of disclosure. The Disclosee can verify the metadata of the private node without the Discloser exposing the actual node contents via the actual node SAID or other attributes.

Private ACDCs (nodes) and private edges may be used in combination to prevent an unpermissioned correlation of the distributed property graph.

#### Operations on edges and edge-groups

When the top-level edge section, `e`, field includes more than one edge there is a need or opportunity to define the logic for evaluating those edges with respect to validating the ACDC itself with respect to the validity of the other ACDCs to which it is connected. More than one edge creates a provenance tree not simply a provenance chain. The obvious default for a chain is that all links in the chain must be valid in order for the chain itself to be valid, or more precisely for the tail of the chain to be valid. If any links between the head and the tail are broken (invalid) then the tail is not valid. This default logic may not be so useful in all cases when a given ACDC is the tail of multiple parallel chains (i.e., a branching node in a tree of chains). Therefore, provided herein is the syntax for exactly specifying the operations to perform on each edge and groups of edge-groups in its edge section.

##### Label types 

There are three types of labels in edge sub-blocks :

[//]: # (format as table)

Reserved field labels (Metadata).
  `d` for SAID of block
  `u` for UUID (salty nonce)
  `n` for node SAID (far ACDC)
  `s` for schema SAID ( far ACDC)
  `o` for Operator
  `w` for Weight

Edge field map labels (single edges) - any value except reserved values above.

Edge-group field map labels (aggregates of Edges) - any value except reserved values above.

##### Block types

There are two types of field maps or blocks that may appear as values of fields within an edge section, `e`, field either at the top level or nested:

###### Edge-group 

An edge-group must not have a node, `n`, metadata field. Its non-metadata field values may include other (sub) edge-group blocks, edge blocks or other properties.

###### Edge

An edge must have a node, `n`, metadata field. Its non-metadata field values must not include edge-group blocks or other edge blocks but may include other types of properties. From a graph perspective, _edge blocks terminate at their node, `n`, field and are not themselves nestable. An _edge block is a leaf with respect to any nested _edge-group_ blocks in which the edge appears. It is therefore also a leaf with respect to its enclosing top-level edge section, `e`, field.  The ACDC node that an edge points to may have its own edge-groups or edges in that node's own top-level edge section.

The top-level edge section, `e`, field value is always an edge-group block.

With respect to the granularity of a property graph consisting of ACDCs as nodes, nested edge-groups within a given top-level edge field, `e`, field of a given ACDC constitute a sub-graph whose nodes are edge-groups, not ACDCs. One of the attractive features of property graphs (PGs) is their support for different edge and node types which enables nested sub-graphs such as is being employed here to support the expression of complex logical or aggregative operations on groups of edges (as subnodes) within the top-level edge section, `e`, field of an ACDC (as supernode).

###### Operator, `o`, field

The meaning of the Operator, `o`, metadata field label depends on which type of block it appears in.

When appearing in an edge-group block, then the operator, `o`, field value is an aggregating (m-ary) operator, such as, `OR`, `AND`, `AVG`, `NAND`, `NOR`, etc. Its operator applies to all the Edges or edge-groups that appear in that edge-group block.

When appearing in an edge block, then the operator, `o`, field value is a unary operator like `NOT`.  When more than one unary operator applies to a given edge, then the value of the Operator, `o`, field is a list of those unary operators.

###### Weight, `w`, field.

Weighted directed edges represent degrees of confidence or likelihood. PGs with weighted directed edges are commonly used for machine learning or reasoning under uncertainty. The Weight, `w` field provides a reserved label for the primary weight. To elaborate, many aggregating operators used for automated reasoning such as the weighted average, `WAVG`, Operator or ranking aggregation operators, depend on each edge having a weight. To simplify the semantics for such operators, the Weight, `w`, field is the reserved field label for weighting. Other fields with other labels could provide other types of weights but having a default label, namely `w`, simplifies the default definitions of weighted operators.

The following example adds a weight property to the edge sub-block as indicated by the Weight, `w`, field.

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLxUdY",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "w": "high"
    }
  }
}
```

###### M-ary operators

There are two basic m-ary operators defined for ACDCs. These are:

| M-ary Operator | Description | Type | Default|
|:-:|:--|:--|:--|
|`AND`| All edges or edge-groups in the edge-group must be valid for the edge-group to be valid  | Combination | Yes |
|`OR`| Only one of the edges or edge-groups in the edge-group must be valid for the edge-group to be valid | Combination |  No |

##### Special unary operators

There are three special unary operators defined for ACDCs. These are:

| Unary Operator | Description |Type | Default|
|:-:|:--|:--|:--|
|`I2I`| Issuee-To-Issuer, Issuer AID of this ACDC must Issuee AID of node the Edge points to  | Constraint | Yes |
|`NI2I`| Not-Issuee-To-Issuer, Issuer AID if any of this ACDC may or may not be Issuee AID of node that the Edge points to | Constraint |  No |
|`DI2I`| Delegated-Issuee-To-Issuer, Issuer AID of this ACDC must be either the Issuee AID or delegated AID of the Issuee AID of the node the edge points to | Constraint | No |

Many ACDC chains use targeted ACDCs (i.e., have Issuees). A chain of Issuer-To-Issuee-To-Issuer targeted ACDCs in which each Issuee becomes the Issuer of the next ACDC in the chain can be used to provide a chain-of-authority. A common use case of a chain-of-authority is a delegation chain for authorization.

The `I2I` unary operator when present means that the Issuer AID of the current ACDC in which the edge resides must be the Issuee AID of the node to which the edge points. This also means, therefore, that the ACDC node pointed to by the edge must also be a Targeted ACDC. This is the default value when none of `I2I`, `NI2I`, or `DI2I` is present.

The `NI2I` unary operator when present removes or nullifies any requirement expressed by the dual `I2I` operator described above. In other words, any requirement that the Issuer AID of the current ACDC in which the edge resides must be the Issuee AID, if any, of the node the edge points to is relaxed (not applicable). To clarify, when operative (present), the `NI2I` Operator means that both an Untargeted ACDC or Targeted ACDC as the node pointed to by the edge still may be valid even when untargeted or if targeted even when the Issuer of the ACDC in which the edge appears is not the Issuee AID, of that node to which the edge points.

The `DI2I` unary Operator when present expands the class of allowed Issuer AIDs of the node the edge resides in to include not only the Issuee AID but also any delegated AIDS of the Issuee of the node to which the edge points.  This also means, therefore, that the ACDC node pointed to by the edge also must be a Targeted ACDC.

If more than one of the `I2I`, `NI2I`, or `DI2I` Operators appear in an Operator, `o`, field list, then the last one appearing in the list is the operative one.

##### Defaults for missing operators

When the Operator, `o`, field is missing in an edge-group block, the default value for the Operator, `o`, field is `AND`.

When the Operator, `o`, field is missing or empty in an edge block, or is present but does not include any of the `I2I`, `NI2I` or `DI2I` Operators then:

If the node pointed to by the edge is a targeted ACDC, i.e., has an Issuee, by default it is assumed that the `I2I` Operator is appended to the Operator, `o`, field's effective list value.

If the node pointed to by the edge block is a Untargeted ACDC i.e., does not have an Issuee, by default, it is assumed that the `NI2I` operator is appended to the Operator, `o`, field's effective list value.

###### Examples

Defaults:

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "power": "high"
    },
   "baby":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "power": "low"
    }
  }
}
```

Explicit AND:

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "o": "AND",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "power": "high"
    },
   "baby":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "o": "NOT",
      "power": "low"
    }
  }
}
```

Unary I2I:

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "o": "AND",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
       "power": "high"
    },
    "baby":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "o": "I2I",
      "power": "low"
    }
  }
}
```

Unary NI2I:

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "o": "OR",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "o": "NI2I",
      "power": "high"
    },
    "baby":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "o": "I2I",
      "power": "low"
    }
  }
}
```

Nested edge-group:

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "o": "AND",
    "boss":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA",
      "o": ["NI2I", "NOT"],
      "power": "high"
    },
    "baby":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "o": "I2I",
      "power": "low"
    },
    "food":
    {
      "o": "OR",
      "power": "med",
      "plum":
      {
        "n": "EQIYPvAu6DZAIl3AORH3dCdoFOLe71iheqcywJcnjtJt",
        "o": "NI2I"
      },
      "pear":
      {
        "n": "EJtQIYPvAu6DZAIl3AORH3dCdoFOLe71iheqcywJcnjt",
        "o": "NI2I"
      }
    }
  }
}
```

###### Default AND example

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/24
:::

When an ECR vLEI is issued by the QVI, it is not chained, Issuer-to-Issuee, via the Legal Entity (LE) vLEI credential. A more accurate way of expressing the chaining would be to use the `AND` Operator to include both the LE and QVI vLEI credentials as edges in the ECR and also to apply the unary `NI2I` to the LE vLEI instead of only chaining the ECR vLEI to the Legal Entity vLEI and not chaining to ECR vLEI to the QVI vLEI at all.

In the following example: The top-level edge-block uses the default of `AND` and the `qvi` edge uses the default of `I2I` because it points to a Targeted ACDC.  The `le` edge, on the other hand, points to a Targeted ACDC. It uses the unary Operator, `NI2I` in its operator, `o`, field so that it will be accepted it even though its targeted Issuee is not the Issuer of the current credential.

```json
{
  "e":
  {
    "d": "EerzwLIr9Bf7V_NHwY1lkFrn9y2PgveY4-9XgOcLx,UdY",
    "qvi":
    {
      "n": "EIl3MORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZA"
    },
    "le":
    {
      "n": "EORH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZAIl3A",
      "o": "NI2I"
    }
  }
}
```


This example provides a simple but highly expressive syntax for applying (m-ary) aggregating Operators to nestable groups of edges and unary Operators to edges individually within those groups. This is a general approach with high expressive power. It satisfies many business logic requirements similar to that of SGL.

Certainly, an even more expressive syntax could be developed. The proposed syntax, however, is relatively simple and compact. It has intelligent defaults and is sufficiently general in scope to satisfy all the currently contemplated use cases.

The intelligent defaults for the Operator, `o`, field, including the default application of the `I2I` or `NI2I` unary operator, means that in most current use cases, the Operator, `o`, field, does not even need to be present.

###### Node discovery

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/26
:::

In general, the discovery of the details of an ACDC referenced as a node, `n` field value, in an edge sub-block begins with the node SAID or the SAID of the associated edge sub-block. Because a SAID is a cryptographic digest with high collision resistance, it provides a universally unique identifier to the referenced ACDC as a node. The discovery of a service endpoint URL that provides database access to a copy of the ACDC may be bootstrapped via an OOBI (Out-Of-Band-Introduction) that links the service endpoint URL to the SAID of the ACDC [@OOBI_ID]. Alternatively, the Issuer may provide as an attachment at the time of issuance a copy of the referenced ACDC. In either case, after a successful exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced ACDCs as nodes in the edge sections of all ACDCs so chained. That Issuee will then have everything it needs to make a successful disclosure to some other Disclosee. This is the essence of Percolated discovery.

### Rule Section  

In the compact ACDC examples above, the rule section has been compacted into merely the SAID of that section. Suppose that the uncompacted value of the rule section denoted by the top-level rule, `r`, field is as follows,

```json
{
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "warrantyDisclaimer":
    {
      "l": "Issuer provides this credential on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE"
    },
    "liabilityDisclaimer":
    {
      "l": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    }
  }
}
```

The purpose of the rule section is to provide a Ricardian Contract [@RC]. The important features of a Ricardian contract are that it be both human and machine-readable and referenceable by a cryptographic digest. A JSON encoded document or block such as the rule section block is a practical example of both a human and machine-readable document.  The rule section's top-level SAID, `d`, field provides the digest.  This provision supports the bow-tie model of RC. Ricardian legal contracts may be structured hierarchically into sections and subsections with named or numbered clauses in each section. The labels on the clauses may follow such a hierarchical structure using nested maps or blocks. These provisions enable the rule section to satisfy the features of a RC.

To elaborate, the rule section's top-level SAID, `d`, field is the SAID of that block and is the same SAID used as the compacted value of the rule section, `r`, field that appears at the top level of the ACDC. Each clause in the rule section gets its own field. Each clause also has its own local label.

The legal, `l`, field in each block provides the associated legal language.

Note there are no type fields in the rule section. The type of a contract and the type of each clause is provided by the schema vis-a-vis the label of that clause. This follows the ACDC design principle that may be succinctly expressed as "type-is-schema".

Each rule section clause may also have its own clause SAID, `d`, field. Clause SAIDs enable reference to individual clauses, not merely the whole contract as given by the rule section's top-level SAID, `d`, field.

An example rule section with clause SAIDs is provided below.

```json
{
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

#### Compact clause

The use of clause SAIDS enables a compact form of a set of clauses where each clause value is the SAID of the corresponding clause. For example,

```json
{
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "warrantyDisclaimer":  "EXgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
    "liabilityDisclaimer": "EY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw"
  }
}
```

#### Simple compact clause

An alternate simplified compact form uses the value of the legal, `l`, field as the value of the clause field label. The schema for a specific clause label will indicate that the field value, for a given clause label is the legal language itself and not the clause block's SAID, `d`, field as is the normal compact form shown above. This alternate simple compact form is shown below. In this form, individual clauses are not compactifiable and are fully self-contained.

```json
{
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "warrantyDisclaimer": "Issuer provides this credential on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE",
    "liabilityDisclaimer": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
  }
}
```

#### Private clause

The disclosure of some clauses may be pre-conditioned on acceptance of Chain-link confidentiality. In this case, some clauses may benefit from Partial disclosure. Thus, clauses may be blinded by their SAID, `d`, field when the clause block includes a sufficiently high entropy UUID, `u`, field. The use of a clause UUID enables the Compact form of a clause not to be discoverable merely from the schema for the clause and its SAID via rainbow table attack [@RB][@DRB]. Therefore such a clause may be partially disclosable. These are called private clauses. A private clause example is shown below.

```json
{
  "r":
  {
    "d": "EwY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NA",
    "warrantyDisclaimer":
    {
      "d": "EXgOcLxUdYerzwLIr9Bf7V_NAwY1lkFrn9y2PgveY4-9",
      "u": "0AG7OY1wjaDAE0qHcgNghkDa",
      "l": "Issuer provides this credential on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE"
    },
    "liabilityDisclaimer":
    {
      "d": "EY1lkFrn9y2PgveY4-9XgOcLxUdYerzwLIr9Bf7V_NAw",
      "u": "0AHcgNghkDaG7OY1wjaDAE0q",
      "l": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    }
  }
}
```

#### Clause discovery 

In compact form, the discovery of either the rule section as a whole or a given clause begins with the provided SAID. Because the SAID, `d`, field of any block is a cryptographic digest with high collision resistance, it provides a universally unique identifier to the referenced block details (whole rule section or individual clause). The discovery of a service endpoint URL that provides database access to a copy of the rule section or to any of its clauses may be bootstrapped via an OOBI that links the service endpoint URL to the SAID of the respective block [@OOBI_ID]. Alternatively, the Issuer may provide as an attachment at issuance a copy of the referenced contract associated with the whole rule section or any clause. In either case, after a successful issuance exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced contracts in whole or in part of all ACDCs so issued. That Issuee will then have everything subsequently needed to make a successful presentation or disclosure to a Disclosee. This is the essence of percolated discovery.


## Disclosure mechanisms and exploitation protection

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/30
:::

An important design goal of ACDCs is to support the sharing of provably authentic data while also protecting against the unpermissioned exploitation of that data. Often the term privacy protection is used to describe similar properties. But a narrow focus on privacy protection may lead to problematic design trade-offs. With ACDCs, the primary design goal is not data privacy protection per se, but the more general goal of protection from the unpermissioned exploitation of data. In this light, a given privacy protection mechanism may be employed to help protect against unpermissioned exploitation of data but only when it serves that more general-purpose and not as an end in and of itself.

### Three-party exploitation model 

Exploitation based on unpermissioned disclosure is characterized with a Three-party model. The three parties are as follows:

- First-party = Discloser of data.
- Second-party = Disclosee of data received from First party (Discloser).
- Third-party = Observer of data disclosed by First party (Discloser) to Second party (Disclosee).

Second-party (Disclosee) exploitation
- Implicit permissioned correlation - no contractual restrictions on the use of disclosed data.
- Explicit permissioned correlation - use as permitted by contract.
Explicit unpermissioned correlation with other Second-parties or Third- parties - malicious use in violation of contract.

Third-party (Observer) exploitation
- Implicit permissioned correlation - no contractual restrictions on the use of observed data.
- Explicit unpermissioned correlation via collusion with Second-parties - malicious use in violation of Second-party contract.


## Exploitation Protection Mechanisms

An ACDC may employ several mechanisms to protect against exploitation using unpermissioned disclosure of data. These are:

- Contractually protected disclosure
    - Chain-link confidentiality [@CLC]
    - Contingent disclosure
- Partial disclosure
- Selective disclosure


For example, the Partial disclosure of portions of an ACDC to enable Chain-link confidentiality of the subsequent full disclosure is an application of the principle of least disclosure. Likewise, unbundling only the necessary attributes from a bundled commitment using Selective disclosure to enable a correlation minimizing disclosure from that bundle is an application of the principle of least disclosure.


### Chain-link confidentiality exchange  

Chain-link confidentiality imposes contractual restrictions and liability on any Disclosee (Second-party) [@CLC]. The exchange provides a fair contract consummation mechanism. The essential steps in a Chain-link confidentiality exchange are shown below. Other steps may be included in a more comprehensive exchange protocol.

- Discloser provides a non-repudiable Offer with verifiable metadata (sufficient Partial disclosure), which includes any terms or restrictions on use.
- Disclosee verifies Offer against composed schema and metadata adherence to desired data.
- Disclosee provides non-repudiable Accept of terms that are contingent on compliant disclosure.
- Discloser provides non-repudiable Disclosure with sufficient compliant detail.
- Disclosee verifies Disclosure using decomposed schema and adherence of disclosed data to Offer.

Disclosee may now engage in permissioned use and carries liability as a deterrent against unpermissioned use.



As described previously, ACDCs employ Graduated disclosure mechanisms that satisfy the principle of least disclosure. Requoted here the principle of least disclosure is as follows:

The system should disclose only the minimum amount of information about a given party needed to facilitate a transaction and no more. [@IDSys]

For example, Compact disclosure, Partial disclosure, Selective disclosure and Full disclosure are all Graduated disclosure mechanisms. Contractually protected disclosure leverages Graduated disclosure so that contractual protections can be put into place using the least disclosure necessary to that end. This minimizes the leakage of information that can be correlated. One type of contractually protected disclosure is Chain-link confidentiality [@CLC].


### Graduated disclosure and Contractually protected disclosure

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/17
:::

ACDC leverages several closely related mechanisms for what can be called Graduated disclosure. Graduated disclosure enables adherence to the principle of least disclosure which is expressed as follows:

The system should disclose only the minimum amount of information about a given party needed to facilitate a transaction and no more. [@IDSys]

To clarify, Graduated disclosure enables a potential Discloser to follow the principle of least disclosure by providing the least amount of information i.e., partial, incomplete, or uncorrelatable information needed to further a transaction.

The important insight is that one type of transaction enabled by least disclosure is a transaction that specifically enables further disclosure. In other words, disclose enough to enable more disclosure which in turn may enable even more disclosure which is the essence of Graduated disclosure. This progression of successive least Graduated disclosures to enable a transaction that itself enables a farther least Graduated disclosure forms a recursive loop of least disclosure enabled transactions. In other words, the principle of least disclosure may be applied recursively.

A type of transaction that leverages Graduated disclosure to enable further disclosure is called a Contractually protected disclosure transaction. In a Contractually protected disclosure, the potential Discloser first makes an offer using the least (partial) disclosure of some information about other information to be disclosed (full disclosure) contingent on the potential Disclosee first agreeing to the contractual terms provided in the offer. The contractual terms could, for example, limit the disclosure to third parties of the yet to be disclosed information. But those contractual terms may also include provisions that protect against liability or other concerns not merely disclosure to third parties.

One special case of a Contractually protected disclosure is a Chain-link confidential disclosure [@CLC].

Another special case of Contractually protected disclosure is Contingent disclosure. In a Contingent disclosure, some contingency is specified in the rule section that places an obligation by some party to make a disclosure when the contingency is satisfied. This might be recourse given the breach of some other term of the contract. When that contingency is met then the Contingent disclosure must be made by the party whose responsibility it is to satisfy that disclosure obligation. The responsible party may be the Discloser of the ACDC or it may be some other party such as an escrow agent. The Contingent disclosure clause may reference a cryptographic commitment to a private ACDC or private attribute ACDC (Partial disclosure) that satisfies via its Full disclosure the Contingent disclosure requirement. Contingent disclosure may be used to limit the actual disclosure of personally identifying information (PII) to a just-in-time, need-to-know basis (i.e., upon the contingency) and not a priori. As long as the Discloser and Disclosee trust the escrow agent and the verifiability of the commitment, there is no need to disclose PII about the Discloser in order to enable a transaction, but merely an agreement to the terms of the contingency. This enables something called latent accountability. Recourse via PII is latent in the Contingent disclosure but is not ever realized (actualized) until recourse is truly needed. The minimizes inadvertent leakage while protecting the Disclosee.

### Types of Graduated disclosure

ACDCs employ three specific closely related types of Graduated disclosure. These are Compact disclosure, Partial disclosure Selective disclosure and Full disclosure . The mechanism for Compact disclosure is a cryptographic digest of the content expressed in the form of a SAID of that content. Both Partial and Selective disclosure rely on the Compact disclosure of content that is also cryptographically blinded or hidden. Content in terms of an ACDC means a block (field map or field map array).

The difference between Partial disclosure and Selective disclosure of a given block is determined by the correlatability of the disclosed field(s) after Full disclosure of the detailed field value with respect to its enclosing block (field map or field map array). A partially disclosable field becomes correlatable after Full disclosure. Whereas a selectively disclosable field may be excluded from the Full disclosure of any other selectively disclosable fields in the selectively disclosable block (usually a field map array). After such Selective disclosure, the selectively disclosed fields are not correlatable to the so-far undisclosed but selectively disclosable fields in that block (field map array).

When used in the context of Selective disclosure, Full disclosure means detailed disclosure of the selectively disclosed attributes not detailed disclosure of all selectively disclosable attributes. Whereas when used in the context of Partial disclosure, Full disclosure means detailed disclosure of the field map that was so far only partially disclosed.

Partial disclosure is an essential mechanism needed to support both performant exchange of information and Contractually protected disclosure such as Chain-link confidentiality on exchanged information [@CLC]. The exchange of only the SAID of a given field map is a type of Partial disclosure. Another type of Partial disclosure is the disclosure of validatable metadata about a detailed field map e.g., the schema of a field map.

The SAID of a field map provides a compact cryptographically equivalent commitment to the yet to be undisclosed field map details.  A later exchange of the uncompacted field map detail provides full disclosure. Any later Full disclosure is verifiable to an earlier Partial disclosure. Partial disclosure via compact SAIDs enables the scalable repeated verifiable exchange of SAID references to cached Full disclosures. Multiple SAID references to cached fully disclosed field maps may be transmitted compactly without redundant retransmission of the full details each time a new reference is transmitted. 

Likewise, Partial disclosure via SAIDs also supports the bow-tie model of Ricardian contracts [@RC]. Similarly, the schema of a field map is metadata about the structure of the field map this is validatable given the Full disclosure of the field mp. The details of compact and/or confidential exchange mechanisms that leverage Partial disclosure are explained later. When the field map includes sufficient cryptographic entropy such as through a UUID field (salty nonce), then the SAID of that field map effectively blinds the contents of the field map. This enables the field map contents identified by its SAID and characterized by its schema (i.e., Partial disclosure) to remain private until later Full disclosure.

Selective disclosure, on the other hand, is an essential mechanism needed to unbundle in a correlation minimizing way a single commitment by an Issuer to a bundle of fields (i.e., a nested array or list or tuple of fields) as a whole. This allows separating a stew (bundle) of ingredients (attributes) into its constituent ingredients (attributes) without correlating the constituents via the Issuer's commitment to the stew (bundle) as a whole.

Another variant of disclosure that is application specific is Disclosure-specific (bespoke) issued ACDCs which is described section 11.4.



## Issuance and Presentation Exchange (IPEX)

The Issuance and Presentation Exchange (IPEX) Protocol provides a uniform mechanism
for the issuance and presentation of ACDCs [@ACDC-ID] in a securely attributable manner.
A single protocol is able to work for both types of exchanges by recognizing
that all exchanges (both issuance and presentation) may be modeled as the
disclosure of information by a Discloser to a Disclosee. The difference between
exchange types is the information disclosed not the mechanism for disclosure.
Furthermore, the chaining mechanism of ACDCs and support for both targeted and
untargeted ACDCs provide sufficient variability to accommodate the differences
in applications or use cases without requiring a difference in the exchange
protocol itself. This greatly simplifies the exchange protocol. This simplification
has two primary advantages. The first is enhanced security. A well-delimited
protocol can be designed and analyzed to minimize and mitigate attack mechanisms.
The second is convenience. A standard simple protocol is easier to implement,
support, update, understand, and adopt. The tooling is more consistent.

This IPEX [@IPEX-ID] protocol leverages important features of ACDCs and ancillary protocols such as CESR [@CESR-ID], SAIDs [@SAID-ID], and CESR-Proofs [@Proof-ID] as well as Ricardian contracts [@RC] and graduated disclosure (partial, selective, full) to enable contractually protected disclosure. Contractually protected disclosure includes both chain-link confidential [@CLC] and contingent disclosure [@ACDC-ID].

### Chain-Link Confidentiality

Disclosures via Presentations Exchanges may be contractually protected by Chain-Link Confidentiality (i.e a Chain-Link Confidential disclosure). The chaining in this case is different from the chaining described above between Issuances in a DAG of chained Issuances. Chain-link confidentiality, in contrast, chains together a sequence of Disclosees. Each Disclosee in the sequence in turn is the Discloser to the next Disclosee. The terms-of-use of the original disclosure as applied to the original Disclosee MUST be applied by each subsequent Discloser to each subsequent Disclosee via each of the subsequent disclosures (presentation exchanges). These terms-of-use typically constrain disclosure to only approved parties, i.e. imbue the chain of disclosures with some degree of confidentiality. These terms-of-use are meant to contractually protect the data rights of the original Issuer or Issuee of the data being disclosed.

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

#### Discussion

All the variants of an ACDC are various degrees of expansion of the compact variant. Therefore, an Issuer commitment via a signature to any variant of ACDC (compact, full, etc)  makes a cryptographic commitment to the top-level section fields shared by all variants of that ACDC because the value of a top level section field is either the SAD or the SAID of the SAD of the associated section. Both a SAD and its SAID, when signed, each provide a verifiable commitment to the SAD. In the former the signature verification is directly agains the SAD itself. In the latter, the SAID as digest must first be verified against its SAD and then the signature on the SAID may be verified. This indirect verifiablity assumes that the cryptographic strength of the SAID digest is equivalent to the cryptographic strength of the signature used to sign it. To clarify, because all variants share the same top level structure as the compact variant, then a signature on any variant  may be used to verify the Issuer's committment to any other variant either directly or indirectly, in whole or in part on a top-level section by top-level section basis. This cross-variant Issuer commitment verifiability is an essential property that supports graduated disclosure by the Disclosee of any or all variants wether it be full, compact, metadata, partial, selective, bulk issued, or contractually protected.

To elaborate, the SAID of a given variant is useful even when it is not the SAID of the variant the Issuer signed because during graduated disclosure the Discloser MAY choose to sign that given variant to fullfill a given step in an IPEX graduated disclosure transaction. The Discloser thereby can make a verifiable disclosure in a given step of the SAD of a given variant that fulfills a commitment made in a prior step via its signature on merely the SAID of the SAD of the variant so disclosed.

For example, the Metadata variant of an ACDC will have a different SAID than the Compact variant because some of the top-level field values may be empty in the Metadata variant. One can think of the The metadata variant as a partial manifest that only includes those top level sections that the Discloser is committing to disclose in order to induce the Disclosee to agree to the contractual terms of use when disclosed. The IPEX transaction is between the Discloser and Disclosee, who both may make non-repudiable commitments via signing to each other. Typically this means that the Discloser will eventually need to fulfull its commitment with a proof of disclosure to the Disclosee. This proof may be satisfied with either directly against the Discloser's signature on the the actual disclosed SAD or indirectly agaisnt the Discloser's signature on the SAID of the actual disclosed SAD. In addition, the Disclosee will typically require a proof of issuance via a non-repudiable signature by the Issuer on a variant of the disclosed SAD that is verifiable (directly or indirectly) against the variant that is the disclosed SAD.

To summarize, when the Issuer commits to the composed schema of an ACDC it is committing to all the variants so composed. As described above, the top level field values in the compact variant enable verification against a disclosure of any of the other Issuer committed variants because they all share the same top level structure. This applies even to the metadata variant in spite of it only providing values for some top level sections and not others. The verifiablity of a top level section is separable.

Consequently, the IPEX protocol must specify how a validator does validation of any variant in a graduated disclosure. To restate there are two proofs that a Discloser must provide. The first is proof of issuance and the second is proof of disclosure. In the former, the Discloser provide the variant via its SAD that was actually signed (as SAD or SAID of SAD) by the Issuer in order for the Disclosee to verify authentic issuance via the signature on that variant.  In the latter, the Discloser must disclose any other Issuer enabled (via schema composition) variants that the Discloser offered to disclose as part of the graduated disclosure process.

#### IPEX Validation

The goal is to define a validation process (set of rules) that works for all variants of an ACDC and for all types of graduated disclosure of that ACDC.

For example, in the bulk issuance of an ACDC, the Issuer only signs the blinded SAID of the SAD that is the Compact variant of the ACDC not the SAD itself. This enable a Discloser to make a proof of inclusion of the ACDC in a bulk issuance set by unblinding the signature on the blinded SAID without leaking correlation to anything but the blinded SAID itself. To clarify, the Disclosee can verify the signature on the SAID without to prove set inclusion with needing the disclosure of any other information about the ACDC. Issuer signing of the SAID not the SAD also has the side benefit of minimizing the computation of large numbers of bulk issued signatures.

##### Issuer Signing Rules

The Issuer MUST provide a signature on the SAID of the most compact variant defined by the schema of the ACDC. When more than one variant is defined by the schema via the oneOf composition operator for any top-level field, the most compact variant MUST appear as the first entry in the oneOf list. When only one variant of each top-level field is defined by the schema, that variant is therefore by defintion the most compact variant.

The different variants of an ACDC form a hash tree (using SAIDs) that is analogous to a Merkle Tree.
Signing the top-level SAID of the compact version of the ACDC is equivalent to signing the Merkle Root of a Merkle Tree.
Different variants of an ACDC (SADs with SAIDs) correspond to different paths through a Merkle tree.
The process of verifying that  a SAD via its SAID of a section is included in a schema authorized variant down from the  top-level SAID is equivalent to a Merkle Tree proof of inclusion along a path in the Merkel Tree down from its Root.
This allows a single signature to provide proof of Issuance of the presentation of any schema authorized variants of the ACDC.

An Issuer MAY provide signatures of the SAIDS of other variants, as well as signatures of the SADs of other variants.

Proof of issuance is provided by disclosing the SAID of the most compact variant and the signature by the Issuer on that SAID.

Proof of disclosure is provided by disclosing the SAD of the most compact variant and then recursively disclosing the nested SADs of each of the top level sections of the most compact variant as needed for the promised disclosure.

Thus for any disclosed variant of an ACDC, the Disclosee need only verify only one proof of issuance as defined above and may need to verify a different proof of disclosure for each disclosed variant as defined above.

### Example Most Compact Variant

The following schema supports a compact variant:

```json
{
  "$id": "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Public ACDC",
  "description": "Example JSON Schema Public ACDC.",
  "credentialType": "PublicACDCExample",
  "type": "object",
  "required": [
    "v",
    "d",
    "i",
    "ri",
    "s",
    "a",
    "e",
    "r"
  ],
  "properties": {
    "v": {
      "description": "ACDC version string",
      "type": "string"
    },
    "d": {
      "description": "ACDC SAID",
      "type": "string"
    },
    "i": {
      "description": "Issuer AID",
      "type": "string"
    },
    "ri": {
      "description": "credential status registry AID",
      "type": "string"
    },
    "s": {
      "description": "schema section",
      "oneOf": [
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
    "a": {
      "description": "attribute section",
      "oneOf": [
        {
          "description": "attribute section SAID",
          "type": "string"
        },
        {
          "description": "attribute detail",
          "type": "object",
          "required": [
            "d",
            "i",
            "score",
            "name"
          ],
          "properties": {
            "d": {
              "description": "attribute section SAID",
              "type": "string"
            },
            "i": {
              "description": "Issuee AID",
              "type": "string"
            },
            "score": {
              "description": "test score",
              "type": "integer"
            },
            "name": {
              "description": "test taker full name",
              "type": "string"
            }
          },
          "additionalProperties": false
        }
      ]
    },
    "e": {
      "description": "edge section",
      "oneOf": [
        {
          "description": "edge section SAID",
          "type": "string"
        },
        {
          "description": "edge detail",
          "type": "object",
          "required": [
            "d",
            "boss"
          ],
          "properties": {
            "d": {
              "description": "edge section SAID",
              "type": "string"
            },
            "boss": {
              "description": "boss edge",
              "type": "object",
              "required": [
                "d",
                "n",
                "s",
                "w"
              ],
              "properties": {
                "d": {
                  "description": "edge SAID",
                  "type": "string"
                },
                "n": {
                  "description": "far node SAID",
                  "type": "string"
                },
                "s": {
                  "description": "far node schema SAID",
                  "type": "string",
                  "const": "EiheqcywJcnjtJtQIYPvAu6DZAIl3MORH3dCdoFOLe71"
                },
                "w": {
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
    "r": {
      "description": "rule section",
      "oneOf": [
        {
          "description": "rule section SAID",
          "type": "string"
        },
        {
          "description": "rule detail",
          "type": "object",
          "required": [
            "d",
            "warrantyDisclaimer",
            "liabilityDisclaimer"
          ],
          "properties": {
            "d": {
              "description": "edge section SAID",
              "type": "string"
            },
            "warrantyDisclaimer": {
              "description": "warranty disclaimer clause",
              "type": "object",
              "required": [
                "d",
                "l"
              ],
              "properties": {
                "d": {
                  "description": "clause SAID",
                  "type": "string"
                },
                "l": {
                  "description": "legal language",
                  "type": "string"
                }
              },
              "additionalProperties": false
            },
            "liabilityDisclaimer": {
              "description": "liability disclaimer clause",
              "type": "object",
              "required": [
                "d",
                "l"
              ],
              "properties": {
                "d": {
                  "description": "clause SAID",
                  "type": "string"
                },
                "l": {
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

The following JSON field map serialization satisfies the rules for most compact variant of the schema above:

```json
{
  "v":  "ACDC10JSON00011c_",
  "d":  "EBdXt3gIXOf2BBWNHdSXCJnFJL5OuQPyM5K0neuniccM",
  "i":  "did:keri:EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
  "ri": "did:keri:EymRy7xMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggt",
  "s":  "E46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4reAXRZOkogZ2A",
  "a":  "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "e":  "ERH3dCdoFOLe71iheqcywJcnjtJtQIYPvAu6DZIl3MOA",
  "r":  "Ee71iheqcywJcnjtJtQIYPvAu6DZIl3MORH3dCdoFOLB"
}
```

The Issuer signs the SAID, `d` field value of the field map above.




### Disclosure-specific (bespoke) issued ACDCs

The ACDC chaining enables disclosure-specific issuance of bespoke ACDCs. A given Discloser of an ACDC issued by some Issuer may want to augment the disclosure with additional contractual obligations or additional information sourced by the Discloser where those augmentations are specific to a given context such as a specific Disclosee. Instead of complicating the presentation exchange to accommodate such disclosure-specific augmentations, a given Discloser issues its own bespoke ACDC that includes the other ACDC of the other Issuer by reference via an edge in the bespoke ACDC. This means that the normal validation logic and tooling for a chained ACDC can be applied without complicating the presentation exchange logic. Furthermore, attributes in other ACDCs pointed to by edges in the bespoke ACDC may be addressed by attributes in the bespoke ACDC using JSON Pointer or CESR-Proof SAD Path references that are relative to the node SAID in the edge [@RFC6901][@Proof_ID].

For example, this approach enables the bespoke ACDC to identify (name) the Disclosee directly as the Issuee of the bespoke ACDC. This enables contractual legal language in the rule section of the bespoke ACDC that reference the Issuee of that ACDC as a named party. Signing the agreement to the offer of that bespoke ACDC consummates a contract between named Issuer and named Issuee. This approach means that custom or bespoke presentations do not need additional complexity or extensions. Extensibility comes from reusing the tooling for issuing ACDCs to issue a bespoke or disclosure-specific ACDC. When the only purpose of the bespoke ACDC is to augment the contractual obligations associated with the disclosure, then the Attribute section, `a`, field value of the bespoke ACD may be empty or it may include properties whose only purpose is to support the bespoke contractual language.

Similarly, this approach effectively enables a type of rich presentation or combined disclosure where multiple ACDCs may be referenced by edges in the bespoke ACDC that each contributes some attribute(s) to the effective set of attributes referenced in the bespoke ACDC. The bespoke ACDC enables the equivalent of a rich presentation without requiring any new tooling [@Abuse].

#### Example of a bespoke issued ACDC

Consider the following disclosure-specific ACDC. The Issuer is the Discloser, the Issuee is the Disclosee. The rule section includes a context-specific (anti) assimilation clause that limits the use of the information to a single one-time usage purpose, that is in this case, admittance to a restaurant.  The ACDC includes an edge that references some other ACDC that may for example be a coupon or gift card. The attribute section includes the date and place of admittance.

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

## Selective disclosure

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/21
:::

As explained previously in section 5, the primary difference between Partial disclosure and Selective disclosure is determined by the correlatability with respect to its encompassing block after Full disclosure of the detailed field value. A partially disclosable field becomes correlatable to its encompassing block after its Full disclosure. Whereas a selectively disclosable field may be excluded from the Full disclosure of any other selectively disclosable fields in its encompassing block. After Selective disclosure, the selectively disclosed fields are not correlatable to the so far undisclosed but selectively disclosable fields in the same encompassing block. In this sense, Full disclosure means detailed disclosure of the selectively disclosed attributes not detailed disclosure of all selectively disclosable attributes.

Recall that Partial disclosure is an essential mechanism needed to support Chain-link confidentiality [@CLC]. The Chain-link confidentiality exchange offer requires partial disclosure, and full disclosure only happens after acceptance of the offer. Selective disclosure, on the other hand, is an essential mechanism needed to unbundle in a correlation minimizing way a single commitment by an Issuer to a bundle of fields (i.e., a nested block or array of fields). This allows separating a "stew" of "ingredients" (attributes) into its constituent ingredients (attributes) without correlating the constituents via the stew.

ACDCs, inherently benefit from a minimally sufficient approach to Selective disclosure that is simple enough to be universally implementable and adoptable. This does not preclude support for other more sophisticated but optional approaches. But the minimally sufficient approach should be universal so that at least one Selective disclosure mechanism be made available in all ACDC implementations. To clarify, not all instances of an ACDC must employ the minimal Selective disclosure mechanisms as described herein but all ACDC implementations must support any instance of an ACDC that employs the minimal Selective disclosure mechanisms as described above.

### Tiered selective disclosure mechanisms

The ACDC chaining mechanism reduces the need for Selective disclosure in some applications. Many non-ACDC verifiable credentials provide bundled credentials because there is no other way to associate the attributes in the bundle of credentials. These bundled credentials could be refactored into a graph of ACDCs. Each of which is separately disclosable and verifiable thereby obviating the need for Selective disclosure.

Nonetheless, some applications require bundled attributes and therefore may benefit from the independent Selective disclosure of bundled attributes. This is provided by selectively disclosable attribute ACDCs.

The use of a revocation registry is an example of a type of bundling, not of attributes in a credential, but uses of a credential in different contexts. Unbundling the usage contexts may be beneficial. This is provided by bulk-issued ACDCs.

Finally, in the case where the correlation of activity of an Issuee across contexts even when the ACDC used in those contexts is not correlatable may be addressed of a variant of bulk-issued ACDCs that have unique Issuee AIDs with an independent Transaction event log (TEL) registry per Issuee instance. This provides non-repudiable (recourse supporting) disclosure while protecting from the malicious correlation between Second-parties and other Second- and/or Third-parties as to who (Issuee) is involved in a presentation.

### Basic selective disclosure mechanism

The basic Selective disclosure mechanism shared by all is comprised of a single aggregated blinded commitment to a list of blinded commitments to undisclosed values. Membership of any blinded commitment to a value in the list of aggregated blinded commitments may be proven without leaking (disclosing) the unblinded value belonging to any other blinded commitment in the list. This enables provable Selective disclosure of the unblinded values. When a non-repudiable digital signature is created on the aggregated blinded commitment then any disclosure of a given value belonging to a given blinded commitment in the list is also non-repudiable. This approach does not require any more complex cryptography than digests and digital signatures. This satisfies the design ethos of minimally sufficient means. The primary drawback of this approach is verbosity. It trades ease and simplicity and adoptability of implementation for size. Its verbosity may be mitigated by replacing the list of blinded commitments with a Merkle tree of those commitments where the Merkle tree root becomes the aggregated blinded commitment.

Given sufficient cryptographic entropy of the blinding factors, collision resistance of the digests, and unforgeability of the digital signatures, either inclusion proof format (list or Merkle tree digest) prevents a potential Disclosee or adversary from discovering in a computationally feasible way the values of any undisclosed blinded value details from the combination of the schema of those value details and either the aggregated blinded commitment and/or the list of aggregated blinded commitments [@Hash][@HCR][@QCHC][@Mrkl][@TwoPI][@MTSec]. A potential Disclosee or adversary would also need both the blinding factor and the actual value details.

Selective disclosure in combination with Partial disclosure for Chain-link confidentiality provides comprehensive correlation minimization because a Discloser may use a non-disclosing metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain-link confidentiality expressed in the rule section [@CLC]. Thus, only malicious Disclosees who violate Chain-link confidentiality may correlate between independent disclosures of the value details of distinct members in the list of aggregated blinded commitments. Nonetheless, they are not able to discover any as-of-yet undisclosed (unblinded) value details.

### Selectively disclosable attribute ACDC

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

The Issuee attribute block is present in an uncompacted untargeted selectively disclosable ACDC as follows:

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

#### Blinded attribute array

Given that each attribute block's UUID, `u`, field has sufficient cryptographic entropy, then each attribute block's SAID, `d`, field provides a secure cryptographic digest of its contents that effectively blinds the attribute value from discovery given only its Schema and SAID. To clarify, the adversary despite being given both the schema of the attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the attribute block in a computationally feasible manner such as a rainbow table attack [@RB][@DRB].  Therefore, the UUID, `u`, field of each attribute block enables the associated SAID, `d`, field to securely blind the block's contents notwithstanding knowledge of the block's schema and that SAID, `d`, field.  Moreover, a cryptographic commitment to that SAID, `d`, field does not provide a fixed point of correlation to the associated attribute (SAD) field values themselves unless and until there has been specific disclosure of those field values themselves.

Given a total of ‘N’ elements in the attributes array, let a<sub>i</sub> represent the SAID, `d`, field of the attribute at zero-based index ‘’'. More precisely, the set of attributes is expressed as the ordered set,

\{a<sub>i</sub> for all i in \{0, ..., N-1\}\}.

The ordered set of a<sub>i</sub> may be also expressed as a list, that is,

\[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].

### Composed Schema for selectively disclosable attribute section

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

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [@BDC][@BDay][@QCHC][@HCR][@Hash].

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

A private selectively disclosable ACDC provides significant correlation minimization because a Discloser may use a metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain-link confidentiality expressed in the rule section [@CLC]. Thus, only malicious Disclosees who violate Chain-link confidentiality may correlate between presentations of a given private selectively disclosable ACDC. Nonetheless, the malicious Disclosees are not able to discover any undisclosed attributes.

#### Inclusion proof via Merkle tree root digest

The inclusion proof via aggregated list may be somewhat verbose when there are a large number of attribute blocks in the selectively disclosable Attribute section. A more efficient approach is to create a Merkle tree of the attribute block digests and let the aggregate, ‘A’, be the Merkle tree root digest [@Mrkl]. Specifically, set the value of the top-level selectively disclosable attribute section, `A`, field to the aggregate, ‘A’ whose value is the Merkle tree root digest [@Mrkl].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [@TwoPI][@MTSec]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, a<sub>j</sub> contributed to the Merkle tree root digest, ‘A. For ACDCs with a small number of attributes, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Hierarchical derivation at issuance of selectively disclosable attribute ACDCs

The amount of data transferred between the Issuer and Issuee (or recipient in the case of an Untargeted ACDC) at issuance of a selectively disclosable attribute ACDC may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUDI, `u`, fields from a shared secret salt [@Salt].

There are several ways that the Issuer may securely share that secret salt. Given that an Ed25519 key pair(s) controls each of the Issuer and Issuee AIDs, (or recipient AID in the case of an Untargeted ACDC), a corresponding X15519 asymmetric encryption Key pair(s) may be derived from each controlling Ed25519 key pair(s) [@EdSC][@PSEd][@TMEd][@SKEM]. An X25519 public key may be derived securely from an Ed25519 public key [@KeyEx][@SKEM]. Likewise, an X25519 private key may be derived securely from an Ed25519 private key [@KeyEx][@SKEM].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [@KeyEx][@DHKE]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used has high entropy cryptographic material from which the secret salt may be derived.

In a non-interactive approach, the Issuer derives an X25519 asymmetric public encryption key from the Issuee's (recipient's) public Ed25519 public key. The Issuer then encrypts the secret salt with that public asymmetric encryption key and signs the encryption with the Issuer's private Ed25519 signing key. This is transmitted to the Issuee, who verifies the signature and decrypts the secret salt using the private X25519 decryption key derived from the Issuee's private Ed25519 key. This non-interactive approach is more scalable for AIDs that are controlled with a multi-sig group of signing keys. The Issuer can broadcast to all members of the Issuee's (or recipient's) multi-sig signing group individually asymmetrically encrypted and signed copies of then may be derived. Likewise, both compact and uncompacted versions of the ACDC then may be generated. The derivation path for the top-level UUID, `u`, field (for private ACDCS), is the string "0" and derivation path the zeroth indexed attribute in the attributes array is the string ‘0/0’. Likewise, the next attribute's derivation path is the string ‘0/1’ and so forth.

In addition to the shared salt and ACDC template, the Issuer also provides its signature(s) on its own generated Compact version ACDC. The Issuer also may provide references to the anchoring issuance proof seals. Everything else an Issuee (or recipient) needs to make a verifiable presentation/disclosure can be computed at the time of presentation/disclosure by the Issuee.

### Bulk-issued private ACDCs

The purpose of bulk issuance is to enable the Issuee to use ACDCs with unique SAIDs more efficiently to isolate and minimize correlation across different usage contexts. Each member of a set of bulk-issued ACDCs is essentially the same ACDC but with a unique SAID. This enables public commitments to each of the unique ACDC SAIDs without correlating between them. A private ACDC may be effectively issued in bulk as a set. In its basic form, the only difference between each ACDC is the top-level SAID, ‘d’, and UUID, ‘u’ field values. To elaborate, bulk issuance enables the use of uncorrelatable copies while minimizing the associated data transfer and storage requirements involved in the issuance. Essentially each copy (member) of a bulk-issued ACDC set shares a template that both the Issuer and Issuee use to generate on-the-fly a given ACDC in that set without requiring that the Issuer and Issuee exchange and store a unique copy of each member of the set independently. This minimizes the data transfer and storage requirements for both the Issuer and the Issuee. The Issuer is only required to provide a single signature for the bulk issued aggregate value ‘B’ defined below. The same signature may be used to provide proof of issuance of any member of the bulk-issued set. The signature on ‘B’ and ‘B’ itself are points of correlation but these need only be disclosed after Contractually protected disclosure is in place, i.e., no permissioned correlation. Thus, correlation requires a colluding Second-party who engages in unpermissioned correlation.

An ACDC provenance chain is connected via references to the SAIDs given by the top-level SAID, `d`, fields of the ACDCs in that chain.  A given ACDC thereby makes commitments to other ACDCs. Expressed another way, an ACDC may be a node in a directed graph of ACDCs. Each directed edge in that graph emanating from one ACDC includes a reference to the SAID of some other connected ACDC. These edges provide points of correlation to an ACDC via their SAID reference. Private bulk-issued ACDCs enable the Issuee to better control the correlatability of presentations using different presentation strategies.

For example, the Issuee could use one copy of a bulk-issued private ACDC per presentation even to the same Verifier. This strategy would consume the most copies. It is essentially a one-time-use ACDC strategy. Alternatively, the Issuee could use the same copy for all presentations to the same Verifier and thereby only permit the Verifier to correlate between presentations it received directly but not between other Verifiers. This limits the consumption to one copy per Verifier. In yet another alternative, the Issuee could use one copy for all presentations in a given context with a group of Verifiers, thereby only permitting correlation among that group.

This is about permissioned correlation. Any Verifier that has received a complete presentation of a private ACDC has access to all the fields disclosed by the presentation but the terms of the Chain-link confidentiality agreement may forbid sharing those field values outside a given context. Thus, an Issuee may use a combination of bulk-issued ACDCs with Chain-link confidentiality to control permissioned correlation of the contents of an ACDC while allowing the SAID of the ACDC to be more public. The SAID of a private ACDC does not expose the ACDC contents to an unpermissioned Third-party. Unique SAIDs belonging to bulk issued ACDCs prevent Third-parties from making a provable correlation between ACDCs via their SAIDs in spite of those SAIDs being public. This does not stop malicious Verifiers (as Second-
-parties) from colluding and correlating against the disclosed fields, but it does limit provable correlation to the information disclosed to a given group of malicious colluding Verifiers. To restate, unique SAIDs per copy of a set of private bulk issued ACDC prevent unpermissioned Third-parties from making provable correlations, in spite of those SAIDs being public, unless they collude with malicious Verifiers (Second-parties).

In some applications, Chain-link-confidentiality is insufficient to deter unpermissioned correlation. Some Verifiers may be malicious with sufficient malicious incentives to overcome whatever counter incentives the terms of the contractual Chain-link confidentiality may impose. In these cases, more aggressive technological anti-correlation mechanisms such as bulk issued ACDCs may be useful. To elaborate, in spite of the fact that Chain-link confidentiality terms of use may forbid such malicious correlation, making such correlation more difficult technically may provide better protection than Chain-link confidentiality alone [@CLC].

It is important to note that any group of colluding malicious Verifiers always may make a statistical correlation between presentations despite technical barriers to cryptographically provable correlation. This is called contextual linkability. In general, there is no cryptographic mechanism that precludes statistical correlation among a set of colluding Verifiers because they may make cryptographically unverifiable or unprovable assertions about information presented to them that may be proven as likely true using merely statistical correlation techniques. Linkability, due the context of the disclosure itself, may defeat any unlinkability guarantees of a cryptographic technique. Thus, without contractually protected disclosure, contextual linkability in spite of cryptographic unlinkability may make the complexity of using advanced cryptographic mechanisms to provide unlinkability an exercise in diminishing returns.

### Basic bulk issuance

The amount of data transferred between the Issuer and Issuee (or recipient of an untargeted ACDC) at issuance of a set of bulk issued ACDCs may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUID, `u`, fields from a shared secret salt [@Salt].

As described above, there are several ways that the Issuer may share a secret salt securely. Given that the Issuer and Issuee (or recipient for Untargeted ACDCs) AIDs are each controlled by an Ed25519 key pair(s), a corresponding X15519 asymmetric encryption key pair(s) may be derived from the controlling Ed25519 key pair(s) [@EdSC][@PSEd][@TMEd]. An X25519 public key may be securely derived from an Ed25519 public key [@KeyEx][@SKEM]. Likewise, an X25519 private key may be securely derived from an Ed25519 private key [@KeyEx][@SKEM].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [@KeyEx][@DHKE]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used has high entropy cryptographic material from which the secret salt may be derived.

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
where H is the digest operator. Blinding is performed by a digest of the concatenation of the binding factor, v<sub>k</sub>, with the SAID, d<sub>k</sub> instead of XORing the two. An XOR of two elements whose bit count is much greater than 2 is not vulnerable to a birthday table attack [@BDay][@DRB][@BDC]. In order to XOR, however, the two must be of the same length. Different SAIDs MAY be of different lengths, however, and therefore, may require different length blinding factors. Because concatenation is length independent it is simpler to implement.

The aggregation of blinded digests, ‘B’, is given by,
B = H(C(b<sub>k</sub> for all k in \{0, ..., M-1\})),
where ‘C’ is the concatenation Operator and ‘H’ is the digest Operator. This aggregate, ‘B’, provides the issuance proof digest.

The aggregate, ‘B’, makes a blinded cryptographic commitment to the ordered elements in the li’t \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] A commitment to ‘B’ is a commitment to all the b<sub>k</sub> and hence all the d<sub>k</sub>.

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [@BDC][@BDay][@QCHC][@HCR][@Hash].

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

The inclusion proof via aggregated list may be somewhat verbose when there are a very large number of bulk-issued ACDCs in a given set. A more efficient approach is to create a Merkle tree of the blinded SAID digests, b<sub>k</sub> and set the aggregate ‘B’ value as the Merkle tree root digest [@Mrkl].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [@TwoPI][@MTSec]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, b<sub>k</sub> contributed to the Merkle tree root digest. For a small-numbered bulk-issued set of ACDCs, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Bulk issuance of private ACDCs with unique issuee AIDs 

One potential point of provable but unpermissioned correlation among any group of colluding malicious Disclosees (Second-party Verifiers) may arise when the same Issuee AID is used for presentation/disclosure to all Disclosees in that group. Recall that the contents of private ACDCs are not disclosed except to permissioned Disclosees (Second-parties). Thus, a common Issuee AID would be a point of correlation only for a group of colluding malicious verifiers. But in some cases removing this unpermissioned point of correlation may be desirable.

One solution to this problem is for the Issuee to use a unique AID for the copy of a bulk-issued ACDC presented to each Disclosee in a given context. This requires that each ACDC copy in the bulk-issued set use a unique Issuee AID. This would enable the Issuee in a given context to minimize provable correlation by malicious Disclosees against any given Issuee AID. In this case, the bulk issuance process may be augmented to include the derivation of a unique Issuee AID in each copy of the bulk-issued ACDC by including in the Inception event that defines a given Issuee's self-addressing AID, a digest seal derived from the shared salt and copy index ‘k’. The derivation path for the digest seal is ‘k/0.’, where ‘k’ is the index of the ACDC. To clarify ‘k/0.’ specifies the path to generate the UUID to be included in the Inception event that generates the Issuee AID for the ACDC at index ‘k’. This can be generated on-demand by the Issuee. Each unique Issuee AID also would need its own KEL. But generation and publication of the associated KEL can be delayed until the bulk-issued ACDC is actually used. This approach completely isolates a given Issuee AID to a given context with respect to the use of a bulk-issued private ACDC. This protects against even the unpermissioned correlation among a group of malicious Disclosees (Second-parties) via the Issuee AID.

## Transaction event log (TEL)

The _Transaction Event Log_ (TEL) is a hash linked data structure of transactions that can be used to track state. A
_Public Verifiable Credential Registry_ can be represented in several TELs to establish issuance or revocation state of
a Verifiable Credential (VC). The KEL is used to establish control authority over the keys used to commit to the events
of the TEL and sign the VC. The events of the TEL are used to establish the issuance or revocation state of the VCs
issued by the controller of the identifier represented by the KEL. This document specifies a design for _public_
VCs only. The use of a hash digest of the VC contents as the identifier of that VC or an attribute in a TEL event allows
for correlation of uses of the VC.

### Public TEL (PTEL)

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/31
:::

A KERI KEL can control a TEL by anchoring the TEL to key events of the KEL with the following:

1. Create the inception event for the TEL with the TEL specific unique identifier.
1. Generate a hash digest of the serialized content of the TEL inception event.
1. Attach anchoring seals from the KEL events to the TEL events they are authorizing.
1. Sign the KEL event as usual to commit to the digest of the serialized TEL event.

Any validator can cryptographically verify the authoritative state by validating the signatures of the referenced KEL.
The TEL events do not have to be signed as the commitment to the event is in the form of the digest in the seal in the
anchoring KEL event and the signatures on that event. Like KEL events, all TEL events have the fields `i`, `s`, and
`t`. However, the `s` or sequence number field in TEL events represents the "clock" for that transaction set. Each
transaction set can have its own "clock" (e.g. bitcoin block height, wall clock, etc) and is independent of the sequence
number of the KEL events. In the case of the Verifiable Credential Registry, the `s` field is simply a monotonically
increasing integer.

The events are anchored back to the KEL using Event Source Seals whose JSON representation is as follows.

```json
{
 "s": "3",
 "d": "ELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM"
}
```

For TEL events, this seal back to the KEL will be delivered as an attachment of event source seal triples in duple of
(s, d).

```
-GAB
0AAAAAAAAAAAAAAAAAAAAAAw
ELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM
```

#### Verifiable Credential Registry

A _Public Verifiable Credential Registry_ (Registry) is a form of a _Verifiable Data Registry_ that tracks the
issuance/revocation state of credentials issued by the controller of the KEL. Two types of TELs will be used for this
purpose. The first type of TEL is the management TEL and will signal the creation of the Registry and track the list of
Registrars that will act as Backers for the individual TELs for each VC. The second type of TEL is the VC TEL which will
track the issued or revoked state of each VC and will contain a reference to it's corresponding management TEL.

The following events will be used to create and maintain the TELs for the Registry.

|Ilk|TEL|Name|Description|
|---|---|---|---|
|vcp| Management |Registry Inception Event | Inception statement for the Registry |
|vrt| Management |Registry Rotation Event | Rotation event for updating Backers |
|iss| VC | Simple Credential Issuance Event | Issue credential with no Backers |
|rev| VC | Simple Credential Revocation Event | Revoke previously issued credential with no Backers |
|bis| VC | Credential Issuance Event | Issue credential |
|brv| VC | Credential Revocation Event | Revoke previously issued credential |
|iis| VC | Simple Credential Issuance Event with VC Hash| Issue credential with no Backers, VC Hash as separate field |
|irv| VC | Simple Credential Revocation Event with VC Hash| Revoke previously issued credential with no Backers, VC Hash as separate field |
|ibs| VC | Credential Issuance Event with VC Hash | Issue credential, VC Hash as separate field |
|ibr| VC | Credential Revocation Event with VC Hash | Revoke previously issued credential, VC Hash as separate field |

Event source seal attachment example (line feeds added for readability)

#### Management TEL

The state tracked by the Management TEL will be the list of Registrar identifiers that serve as backers for each TEL
under its provenance. This list of Registrars can be rotated with events specific to this type of TEL. In this way,
Registrar lists are analogous to Backer lists in KERI KELs. Additional metadata can be tracked in this TEL, for example
references to Schema. The Management TEL will have two events: `vcp` for Registry inception and `vrt`
for rotation of the list or Registrars. The events will reference the controlling identifier in the `ii` field and be
anchored to the KEL with an event seal triple attachment.

The Registry specific identifier will be self-addressing (see [below](#self-addressing-identifiers)
for definition) using its inception data for its derivation. This requires a commitment to the anchor in the controlling
KEL and necessitates the event location seal be included in the event. The derived identifier is then set in the `i`
field of the events in the management TEL.

Though it is possible for a given identifier KEL to issue multiple types of credentials, it is anticipated that there
will be relatively few (usually one) Management TELs anchored to a given KEL. A more scalable approach to issuing
multiple credential types from a single identifier would be to use delegated identifiers for the different types of
credentials to be issued.

|Label|Description|Notes|
|---|---|---|
|v| version string | |
|i| namespaced identifier of Registry | |
|s| sequence number of event |  |
|t| message type  of event |  |
|p| prior event digest | |
|c| list of Configuration Traits/Modes | allows for config of no backer registry |
|a| digest seal of attachment meta-data for registry |
|ii| issuer identifier | |
|vi| hash digest of VC contents | |
|b| list of backer identifiers for credentials associated with this registry | |
|bt| backer threshold | |
|ba| list of backers to add (ordered backer set) | |
|br| list of backers to remove (ordered backer set) | |

##### Configuration

The simplest (and most common) case for Registries relies on the witnesses of the controlling KEL and their receipts of
the KEL events instead of Registry specific backers. To accommodate this case, the `c` element is added to the
management TEL inception event with the configuration option `NB`  to specify that the Registry will never have backers
configured in the management TEL. In this case, there will only be one event in the management TEL for this Registry and
the simple events `iss`
and `rev` will be used for "simple issue" and "simple revoke" respectively in the VC specific TELs. For these events,
the `ri` field will be the simple identifier referencing the management TEL.

|Option|Description|Notes|
|---|---|---|
|NB| No Backers | No registry specific backers will be configured for this Registry |

##### Registry Inception Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A",
 "ii": "EJJR2nmwyYAfSVPzhzS6b5CMZAoTNZH3ULvaU6Z-i0d8",
 "s" : "0",
 "t" : "vcp",
 "b" : ["BbIg_3-11d3PYxSInLN-Q9_T2axD6kkXd3XRgbGZTm6s"],
 "c" : []
 "a" : {
     "d": "EEBp64Aw2rsjdJpAR0e2qCq3jX7q7gLld3LjAwZgaLXU"
  }
}-GAB0AAAAAAAAAAAAAAAAAAAAABwEOWdT7a7fZwRz0jiZ0DJxZEM3vsNbLDPEUk-ODnif3O0
```

Registry inception event for establishing the list of Backers:

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A",
 "ii": "EJJR2nmwyYAfSVPzhzS6b5CMZAoTNZH3ULvaU6Z-i0d8",
 "s" : "0",
 "t" : "vcp",
 "b" : [],
 "c" : ["NB"]
}-GAB0AAAAAAAAAAAAAAAAAAAAABwEOWdT7a7fZwRz0jiZ0DJxZEM3vsNbLDPEUk-ODnif3O0
```

Registry inception event for "backer-less" configuration.

##### Registry Rotation Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A",
 "p" : "EY2L3ycqK9645aEeQKP941xojSiuiHsw4Y6yTW-PmsBg",
 "s" : "1",
 "t" : "vrt",
 "ba" : ["BXhpfP_H41hw8f-LluTidLfXxmC4EPwaENHI6CuruE6g"],
 "br" : ["BbIg_3-11d3PYxSInLN-Q9_T2axD6kkXd3XRgbGZTm6s"]
}-GAB0AAAAAAAAAAAAAAAAAAAAACQEOWdT7a7fZwRz0jiZ0DJxZEM3vsNbLDPEUk-ODnif3O0
```

Registrar rotation event updates the list of Backers.

#### Verifiable Credential TELs

The binary state (issued or revoked) of each verifiable credential (VC) will be tracked in individual TELs associated
with each VC. The state changes will be represented by 4 sets of 2 events: `iss` for simple VC issuance and `rev`
for simple revocation, `bis` for the issuance of the VCs with backers and `brv` for revocation of the VCs with backers
and corresponding events `iis`, `irv` and `ibs`, `ibr` to be used when the identifier of the VC is not the
self-addressing identifier of the VC and that identifier must be included is the separate `vi` field in the event. The
events will be anchored to the KEL with an event seal triple attachment signified by the grouping counter `-e##`.

##### Self Addressing Identifiers

The advantage of a content addressable identifier is that it is cryptographically bound to the contents. It provides a
secure root-of-trust. Any cryptographic commitment to a content addressable identifier is functionally equivalent (given
comparable cryptographic strength) to a cryptographic commitment to the content itself.

A self-addressing identifier is a special class content-addressable identifier that is also self-referential. The
special class is distinguished by a special derivation method or process to generate the self-addressing identifier.
This derivation method is determined by the combination of both a derivation code prefix included in the identifier and
the context in which the identifier appears. The reason for a special derivation method is that a naive cryptographic
content addressable identifier must not be self-referential, i.e. the identifier must not appear within the contents
that it is identifying. This is because the naive cryptographic derivation process of a content addressable identifier
is a cryptographic digest of the serialized content. Changing one bit of the serialization content will result in a
different digest. A special derivation method or process is required.

##### Derivation Process

This process is as follows:

- replace the value of the id field in the content that will hold the self-addressing identifier with a dummy string of
  the same length as the eventually derived self-addressing identifier
- compute the digest of the content with the dummy value for the id field
- prepend the derivation code to the digest and encode appropriately to create the final derived self-addressing
  identifier replace the dummy value with the self-addressing identifier

As long as any verifier recognizes the derivation method, the 'self-addressing` identifier is a cryptographically secure
commitment to the contents in which it is embedded. It is a cryptographically verifiable self-referential content
addressable identifier.

Because a self-addressing identifier is both self-referential and cryptographically bound to the contents it identifies,
anyone can validate this binding if they follow the binding protocol outlined above.

To elaborate, this approach of deriving self-referential identifiers from the contents they identify, we call
self-addressing. It allows a verifier to verify or re-derive the self-referential identifier given the contents it
identifies. To clarify, a self-addressing identifier is different from a standard content address or content addressable
identifier in that a standard content addressable identifier may not be included inside the contents it addresses. The
standard content addressable identifier is computed on the finished immutable contents and therefore is not
self-referential.

#### Self-Addressing Identifiers in a TEL

`ii` issuer identifier is the controller prefix is self-certifying and may be also self-addressing (but may not be) wrt
to its inception event  (For GLEIF TELS the issuer identifier must be self-addressing)

`ri`, `i` registry identifier is self-addressing wrt the registry inception event `i` VC identifier is self-addressing
wrt to the VC itself

There are two options for including a cryptographic commitment to the VC in the TEL VC events. The identifier of the VC
can self-addressing using the same technique KERI uses for self-addressing identifiers. The VC identifier can be created
by padding the VC `id` field and taking a hash digest of the serialized contents of the VC. This form of self-addressing
identifier can be used as the `i` field in the TEL `iss`, `rev`, `bis` and `brv` events and no other reference to the VC
is required. When the identifier of the VC is derived from some other method, the TEL events `iis`, `irv`, `ibs` and
`ibr` are used, and a hash digest of the contents of the VC is placed in the `vi` field.

The VC identifier can be namespaced using DID syntax. In this case, the VC identifier in the TEL events would be the
method specific identifier of the full DID. For informational purposes, the fully qualified DID can be included as an
attachment to the TEL events.

The list of backers needed to sign each VC TEL event is maintained by the management TEL. Since that list can change
over time with the `rot` management events listed above, the non-simple VC events (`bis`, `brv`) must be anchored to the
event in the management TEL at the point when the VC event is published with the `ra` field. This way, the backer
signatures can be indexed into the proper list of backers at the time of issuance or revocation.

#### Credential Issuance/Revocation TEL

|Label|Description|Notes|
|---|---|---|
|v| version string | |
|i| namespaced identifier of VC | |
|s| sequence number of event |  |
|t| message type  of event |  |
|dt| issuer system data/time in iso format | |
|p| prior event digest | |
|ri| registry identifier from management TEL | |
|ra| registry anchor to management TEL | |

##### Simple Credential Issuance Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4",
 "s" : "0",
 "t" : "iss",
 "dt": "2021-05-27T19:16:50.750302+00:00",
 "ri": "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A"
}-GAB0AAAAAAAAAAAAAAAAAAAAAAwELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM
```

##### Simple Credential Revocation Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4",
 "s" : "1",
 "t" : "rev",
 "dt": "2021-05-27T19:16:50.750302+00:00",
 "p" : "EY2L3ycqK9645aEeQKP941xojSiuiHsw4Y6yTW-PmsBg"
}-GAB0AAAAAAAAAAAAAAAAAAAAABAELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM
```

##### Credential Issuance Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4",
 "s" : "0",
 "t" : "bis",
 "dt": "2021-05-27T19:16:50.750302+00:00",
 "ra": {
    "i": "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A",
    "s": "2",
    "d": "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4"
  }
}-GAB0AAAAAAAAAAAAAAAAAAAAAAwELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM
```

##### Credential Revocation Event

```json
{
 "v" : "KERI10JSON00011c_",
 "i" : "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4",
 "s" : "1",
 "t" : "brv",
 "dt": "2021-05-27T19:16:50.750302+00:00",
 "p" : "EY2L3ycqK9645aEeQKP941xojSiuiHsw4Y6yTW-PmsBg",
 "ra": {
    "i": "ELh3eYC2W_Su1izlvm0xxw01n3XK8bdV2Zb09IqlXB7A",
    "s": "4",
    "d": "Ezpq06UecHwzy-K9FpNoRxCJp2wIGM9u2Edk-PLMZ1H4"
  }
}-GAB0AAAAAAAAAAAAAAAAAAAAABAELvaU6Z-i0d8JJR2nmwyYAZAoTNZH3UfSVPzhzS6b5CM
```

#### Use Case

The _Verifiable Legal Entity Identifier_ (vLEI) provides a lightweight, easy to understand use case for a _Transaction
Event Log_ as a _Verifiable Credential Registry_. Issuing a VC has been described above. Verification of a VC will start
with the presentation of a vLEI VC as proof (all vLEI VCs are public and therefore proof presentation will include the
entire vLEI VC). The verifier will extract the DID of the issuer from the VC, and calculate the hash digest of the
serialized contents of the VC. By parsing the namespaced identifier of the VC, the verifier will perform the following
steps:

1. Retrieve the key state from the KERI did method (or appropriate DID method tunnel) using the controller identifier
   embedded in the VC identifier
1. Retrieve and verify the KEL against the key state of the issuer
1. Retrieve the management TEL using the Registry identifier embedded in the VC identifier and determine the Registrars
   to use to retrieve the VC TEL.
1. Retrieve the VC TEL and calculate the issuance/revocation state of the VC from the events in the TEL.
1. Using the keys from the KERI event to which the `iss` event is anchored, verify the signature on the VC.


## FIX ME
### Blindable state TEL 

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/32
:::

In some applications, it is desirable that the current state of a TEL be hidden or blinded such that the only way for a potential Verifier of the state to observe that state is when the Controller of a designated AID discloses it at the time of presentation. This designated AID is called the Discloser. Typically for ACDCs that have an Issuee, the Discloser is the Issuee, but the Issuer could designate any AID as the Discloser. Only the Discloser will be able to unblind the state to a potential Disclosee.

In a blindable state TEL, the state disclosure is interactive. A Disclosee may observe the state only when unblinded via an interactive exchange with the Discloser. After disclosure, the Discloser may then request that the Issuer update the state with a new blinding factor (the blind). The Disclosee cannot then observe the current state of the TEL without yet another disclosure interaction with the Discloser.

The blind is derived from a secret salt shared between the Issuer and the designated Discloser. The current blind is derived from this salt, and the sequence number of the TEL event is so blinded. To elaborate, the derivation path for the blind is the sequence number of the TEL event, which in combination with the salt, produces a universally unique salty nonce for the blind. Only the Issuer and Discloser have a copy of the secret salt, so only they can derive the current blind. The Issuer provides a service endpoint to which the Discloser can make a signed request to update the blind.  Each new event in the TEL must change the blinding factor but may or may not change the actual blinded state. Only the Issuer can change the actual blinded state. Because each updated event in the TEL has a new blinding factor regardless of an actual change of state or not, an observer cannot correlate state changes to event updates as long as the Issuer regularly updates the blinding factor by issuing a new TEL event.

Blindable state TEL events use a unique event type, `upd`. The event state is hidden in the `a` field, whose value is the blinded SAID of a field map that holds the TEL state. The field map's SAID is its `d` field. The blinding factor is provided in the field map's `u` field. The SAID of the associated ACDC is in the field map's `i` field or else the aggregate value for bulk-issued ACDCs. The actual state of the TEL for that ACDC is provided by other fields in the `a`, field map. A simple state could use the `s` field for state or status.

When the `u` field is missing or empty, then the event is not blindable. When the `u` field has sufficient entropy, then the SAID of the enclosing field map effectively blinds the state provided by that map. The Discloser must disclose the field map to the Disclosee, who can verify that its SAID matches the SAID in the TEL.  A subsequent update event entered into that TEL will then re-blind the state of the TEL so that any prior Disclosees may no longer verify the current state of the TEL.

Blindable state TEL top-Level fields:  

|Label|Description|Notes|
|---|---|---|
|v| version string | |
|d| event digest | SAID |
|s| sequence number of event |  |
|t| message type  of event | `upd`  |
|dt| issuer system data/time in iso format | |
|p| prior event digest | SAID |
|ri| registry identifier from management TEL | |
|ra| registry anchor to management TEL | |
|a| state attributed digest | SAID |

Blindable state TEL attribute (state) fields: 

|Label|Description|Notes|
|---|---|---|
|d| attribute digest | SAID |
|u| salty nonce blinding factor | UUID |
|i| namespaced identifier of VC or aggregate when bulk-issued | SAID or Aggregate |
|s| state value | `issued` or `revoked` |

### Transfer registry TEL

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/34
:::

### Independent TEL bulk-issued ACDCs

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/33
:::

Recall that the purpose of using the aggregate ‘B for a bulk-issued set from which the TEL identifier is derived is to enable a set of bulk-issued ACDCs to share a single public TEL and/or a single anchoring seal in the Issuer's KEL without enabling unpermissioned correlation to any other members of the bulk set by virtue of the shared aggregate ‘B’ used for either the TEL or anchoring seal in the KEL. When using a TEL, this enables the issuance/revocation/transfer state of all copies of a set of bulk-issued ACDCs to be provided by a single TEL which minimizes the storage and compute requirements on the TEL registry while providing Selective disclosure to prevent unpermissioned correlation via the public TEL. When using an anchoring seal, this enables one signature to provide proof of inclusion in the bulk-issued aggregate ‘B’.

However, in some applications where Chain-link confidentiality does not sufficiently deter malicious provable correlation by Disclosees (Second-party Verifiers), an Issuee may benefit from using ACDC with independent TELs or independent aggregates ‘B’ but that are still bulk-issued.

In this case, the bulk issuance process must be augmented so that each uniquely identified copy of the ACDC gets its own TEL entry (or equivalently its own aggregate ‘B’) in the registry. Each Disclosee (Verifier) of a full presentation/disclosure of a given copy of the ACDC only receives proof of one uniquely identified TEL and cannot provably correlate the TEL state of one presentation to any other presentation because the ACDC SAID, the TEL identifier, and the signature of the Issuer on each aggregate ‘B’ will be different for each copy. There is, therefore, no point of provable correlation, permissioned or otherwise. For example, this approach could be modulated by having a set of smaller bulk issued sets that are more contextualized than one large bulk-issued set.

The obvious drawbacks of this approach (independent unique TELs for each private ACDC) are that the size of the registry database increases as a multiple of the number of copies of each bulk-issued ACDC and every time an Issuer must change the TEL state of a given set of copies it must change the state of multiple TELs in the registry. This imposes both a storage and computation burden on the registry. The primary advantage of this approach, however, is that each copy of a private ACDC has a uniquely identified TEL. This minimizes unpermissioned Third-party exploitation via provable correlation of TEL identifiers even with colluding Second-party Verifiers. They are limited to statistical correlation techniques.

In this case, the set of private ACDCs may or may not share the same Issuee AID because for all intents and purposes each copy appears to be a different ACDC even when issued to the same Issuee. Nonetheless, using unique Issuee AIDs may further reduce correlation by malicious Disclosees (Second-party verifiers) beyond using independent TELs.

To summarize the main benefit of this approach, in spite of its storage and compute burden, is that in some applications Chain-link confidentiality does not sufficiently deter unpermissioned malicious collusion. Therefore, completely independent bulk-issued ACDCs may be used.


[//]: # (\backmatter)

[//]: # (Performance and Scalability {#sec:annexA .informative})

## Annex

### Performance and Scalability

The compact disclosure and distribute property graph fragment mechanisms in ACDC can be leveraged to enable high performance at scale. Simply using SAIDs and signed SAIDs of ACDCs in whole or in part enables compact but securely attributed and verifiable references to ACDCs to be employed anywhere performance is an issue. Only the SAID and its signature need be transmitted to verify secure attribution of the data represented by the SAID. Later receipt of the data may be verified against the SAID. The signature does not need to be re-verified because a signature on a SAID is making a unique (to within the cryptographic strength of the SAID) commitment to the data represented by the SAID. The actual detailed ACDC in whole or in part may then be cached or provided on-demand or just-in-time.

Hierarchical decomposition of data into a distributed verifiable property graph, where each ACDC is a distributed graph fragment, enables performant reuse of data or more compactly performant reuse of SAIDs and their signatures. The metadata and attribute sections of each ACDC provide a node in the graph and the edge section of each ACDC provides the edges to that node. Higher-up nodes in the graph with many lower-level nodes need only be transmitted, verified, and cached once per every node or leaf in the branch not redundantly re-transmitted and re-verified for each node or leaf as is the case for document-based verifiable credentials where the whole equivalent of the branched (graph) structure must be contained in one document. This truly enables the bow-tie model popularized by Ricardian contracts, not merely for contracts, but for all data authenticated, authorized, referenced, or conveyed by ACDCs.

[//]: # (Cryptographic Strength and Security {#sec:annexB .informative})

### Cryptographic Strength and Security

#### Cryptographic Strength

For crypto-systems with perfect-security, the critical design parameter is the number of bits of entropy needed to resist any practical brute force attack. In other words, when a large random or pseudo-random number from a cryptographic strength pseudo-random number generator (CSPRNG) [@CSPRNG] expressed as a string of characters is used as a seed or private key to a cryptosystem with perfect-security, the critical design parameter is determined by the amount of random entropy in that string needed to withstand a brute force attack. Any subsequent cryptographic operations must preserve that minimum level of cryptographic strength. In information theory, [@IThry][@ITPS] the entropy of a message or string of characters is measured in bits. Another way of saying this is that the degree of randomness of a string of characters can be measured by the number of bits of entropy in that string.  Assuming conventional non-quantum computers, the conventional wisdom is that, for systems with information-theoretic or perfect-security, the seed/key needs to have on the order of 128 bits (16 bytes, 32 hex characters) of entropy to practically withstand any brute force attack. A cryptographic quality random or pseudo-random number expressed as a string of characters will have essentially as many bits of entropy as the number of bits in the number. For other crypto systems such as digital signatures that do not have perfect-security, the size of the seed/key may need to be much larger than 128 bits in order to maintain 128 bits of cryptographic strength.

An N-bit long base-2 random number has 2<sup>N</sup> different possible values. Given that no other information is available to an attacker with Perfect security, the attacker may need to try every possible value before finding the correct one. Thus, the number of attempts that the attacker would have to try maybe as much as 2<sup>N-1</sup>.  Given available computing power, one can show easily that 128 is a large enough N to make brute force attack computationally infeasible.

Suppose that the adversary has access to supercomputers. Current supercomputers can perform on the order of one quadrillion operations per second. Individual CPU cores can only perform about 4 billion operations per second, but a supercomputer will parallelly employ many cores. A quadrillion is approximately 2<sup>50</sup> = 1,125,899,906,842,624. Suppose somehow an adversary had control over one million (2<sup>20</sup> = 1,048,576) supercomputers which could be employed in parallel when mounting a brute force attack. The adversary could then try 2<sup>50</sup> * 2<sup>20</sup> = 2<sup>70</sup> values per second (assuming very conservatively that each try only took one operation).

There are about 3600 * 24 * 365 = 313,536,000 = 2<sup>log<sub>2</sub>313536000</sup>=2<sup>24.91</sup> ~= 2<sup>25</sup> seconds in a year. Thus, this set of a million super computers could try 2<sup>50+20+25</sup> = 2<sup>95</sup> values per year. For a 128-bit random number this means that the adversary would need on the order of 2<sup>128-95</sup> = 2<sup>33</sup> = 8,589,934,592 years to find the right value. This assumes that the value of breaking the cryptosystem is worth the expense of that much computing power. Consequently, a cryptosystem with perfect-security and 128 bits of cryptographic strength is computationally infeasible to break via brute force attack.

#### Information theoretic Security and perfect-security

The highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key) is called  information theoretic security[@ITPS]. A cryptosystem that has this level of security cannot be broken algorithmically even if the adversary has nearly unlimited computing power including quantum computing. The system must be broken by brute force if at all. Brute force means that in order to guarantee success, the adversary must search for every combination of key or seed. A special case of information-theoretic security is called *perfect-security* [@ITPS].  Perfect-security means that the ciphertext provides no information about the key. There are two well-known cryptosystems that exhibit *perfect-security. The first is a One-time-pad (OTP) or Vernum Cipher [@OTP][@VCphr], and the other is Secret splitting [@SSplt], a type of secret sharing [@SShr] that uses the same technique as an OTP.


[//]: # (# Examples {#sec:annexC .informative} )

### Examples 

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
  "ri": "did:keri:EymRy7xMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggt",
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
  "ri": "did:keri:EymRy7xMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggt",
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
    "ri",
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
    "ri":
    {
      "description": "credential status registry ID",
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

### Extensibility

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/35
:::

Append-only verifiable data structures have strong security properties that simplify end-verifiability and foster decentralization.

Append-only provides permission-less extensibility by downstream issuers, presenters, and/or verifiers

Each ACDC has a universally-unique content-based identifier with a universally-unique content-based schema identifier.

Fully decentralized name-spacing.

Custom fields are appended via chaining via one or more custom ACDCs defined by custom schema (type-is-schema).

No need for centralized permissioned name-space registries to resolve name-space collisions.

The purposes of a registry now become merely schema discovery or schema blessing for a given context or ecosystem.

The reach of the registry is tuned to the reach of desired interoperability by the ecosystem participants.

Human meaningful labels on SAIDs are local context only.

Versioning is simplified because edges still verify if new schema are backwards compatible. (persistent data structure model).


[//]: # (\newpage)

[//]: # (\makebibliography)

[//]: # (# Bibliography)
