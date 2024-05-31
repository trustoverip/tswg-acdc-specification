## ACDC Structure
<!-- file name: acdc-structure.md -->
### Ordered nested field maps

An ACDC may be modeled abstractly as a nested `key: value` mapping. To avoid confusion with the cryptographic use of the term key,  the term field is used instead to refer to a mapping pair and the terms field label and field value for each member of a pair. These pairs can be represented by two tuples, e.g., `(label, value)`. This terminology can be qualified, when necessary, by using the term field map to reference such a mapping. Field maps may be nested where a given field value is itself a reference to another field map. A nested set of fields is called a nested field map or simply a nested map for short. 

A field may be represented by a [[ref: Framing Code]] or block delimited serialization.  In a block delimited serialization, such as JSON, each field map is represented by an object block with block delimiters such as `{}` [[8]] [[7]] [[9]]. Given this equivalence, the term block or nested block also may be used as synonymous with field map or nested field map. In many programming languages, a field map is implemented as a dictionary or hash table in order to enable performant asynchronous lookup of a field value from its field label. Reproducible serialization of field maps requires a canonical ordering of those fields. One such canonical ordering is called insertion or field creation order. A list of `(field, value)` pairs provides an ordered representation of any field map. Most programming languages now support ordered dictionaries or hash tables that provide reproducible iteration over a list of ordered field `(label, value)` pairs where the ordering is the insertion or field creation order. This enables reproducible round-trip serialization/deserialization of field maps.  ACDCs depend on insertion ordered field maps for canonical serialization/deserialization. ACDCs support multiple serialization types, namely JSON, CBOR, MGPK, and CESR but for the sake of simplicity, JSON only will be used for examples [[8]] [[7]]. The basic set of normative field labels in ACDC field maps is defined in the following table.


### Top-Level fields

The following table defines the top-level fields in an ACDC and their order of appearance. Some fields are optional but all fields that appear must appear in a defined order.

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: `ACDCMmmKKKKSSSS.` that provides protocol type, version, serialization type, size, and terminator. |
|`d`| Digest ([[3]]) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Issuer Identifier ([[ref: AID]])| Autonomic Identifier whose control authority is established via KERI verifiable Key State. |
|`rd`| Registry Digest ([[3]]) | Issuance and/or revocation, transfer, or retraction registry for ACDC |
|`s`| Schema| Either the [[3]] of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the [[3]] of a block of Attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of attributes or the block itself. |
|`e`| Edge| Either the [[3]] of a block of Edges or the block itself.|
|`r`| Rule | Either the [[3]] a block of Rules or the block itself. |

#### Field ordering

When present, the top-level fields shall appear in the following order: `[v, d, u, i, rd, s, a, A, e, r]`. 

#### Required fields

The following fields are required `[v, d, i, s]`. 

### Other reserved fields

The following table defines non-top-level fields whose labels are reserved. 
These appear at other levels besides the top-level of an ACDC. 

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest ([[3]]) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Identifier ([[ref: AID]])| Context dependent AID as determined by its enclosing map such as Issuee identifier. |
|`n`| Node| [[3]] of another ACDC as the terminating point (vertex) of a directed Edge that connects the encapsulating ACDC node to the specified ACDC node as a fragment of a distributed property graph (PG).|
|`o`| Operator| Either unary operator on Edge or m-ary operator on edge-group in Edge section. Enables expressing of Edge logic on Edge subgraph.|
|`w`| Weight| Edge weight property that enables default property for directed weighted edges and operators on directed weighted edges.|
|`l`| Legal Language| Text of Ricardian contract clause.|

### Compact labels

The primary field labels are compact in that they use only one or two characters. ACDCs are meant to support resource-constrained applications such as supply chain or IoT (Internet of Things) applications. Compact labels better support resource-constrained applications in general. With compact labels, the over-the-wire verifiable signed serialization consumes a minimum amount of bandwidth. Nevertheless, without loss of generality, a one-to-one normative semantic overlay using more verbose expressive field labels may be applied to the normative compact labels after verification of the over-the-wire serialization. This approach better supports bandwidth and storage constraints on transmission while not precluding any later semantic post-processing. This is a well-known design pattern for resource-constrained applications.

### Version String field

The Version String, `v`, field shall be the first field in any top-level ACDC field map encoded in JSON, CBOR, or MGPK as a Message body [[spec: RFC4627]] [[spec: RFC4627]] [[12]] [[13]] [[14]]. It provides a regular expression target for determining a serialized field map's serialization format and size (character count) constituting an ACDC message body. A Stream parser may use the Version String to extract and deserialize (deterministically) any serialized Stream of ACDC Message bodies. Each ACDC Message body in a Stream may use a different serialization type. The format for the Version String field value is defined in the CESR specification [[1]]. 

The protocol field, `PPPP` value in the Version String shall be `ACDC` for the ACDC protocol. The version field, `VVV`, shall encode the current version of the ACDC protocol [[1]].

##### Legacy Version String field format

Compliant ACDC version 2.XX implementations shall support the old ACDC version 1.x Version String format to properly verify Message bodies created with 1.x format events. The old version 1.X Version String format is defined in the CESR specification [[1]]. The protocol field, `PPPP` value in the version string shall be `ACDC` for the ACDC protocol. The version field, `vv`, shall encode the old version of the ACDC protocol [[1]].


### Self-addressing identifier (SAID) fields

Some fields in ACDCs may have for their value either a field map or a SAID. A SAID follows the SAID protocol [[3]]. A SAID is a special type of cryptographic digest of its encapsulating field map (block). The encapsulating block of a SAID is called a SAD (Self-addressed data). Using a SAID as a field value enables a more compact but secure representation of the associated block (SAD) from which the SAID is derived. Any nested field map that includes a SAID field (i.e., is, therefore, a SAD) may be compacted into its SAID. The uncompacted blocks for each associated SAID may be attached or cached to optimize bandwidth and availability without decreasing security.

Several top-level ACDC fields may have for their value either a serialized field map or the SAID of that field map. Each SAID provides a stable, universal, cryptographically verifiable, and agile reference to its encapsulating block (serialized field map). These include the `d`, and `rd` fields. Moreover, the value of top-level `s`, `a`, `e`, and `r` fields may be replaced by the SAID of their associated field map. When replaced by their SAID, these top-level sections are in compact form.

Recall that a cryptographic commitment (such as a digital signature or cryptographic digest) on a given digest with sufficient cryptographic strength, including collision resistance [[34]] [[35]], is equivalent to a commitment to the block from which the given digest was derived.  Specifically, a digital signature on a SAID makes a verifiable cryptographic non-repudiable commitment that is equivalent to a commitment on the full serialization of the associated block from which the SAID was derived. This enables reasoning about ACDCs in whole or in part via their SAIDs in a fully interoperable, verifiable, compact, and secure manner. This also supports the well-known bow-tie model of Ricardian Contracts [[43]]. This includes reasoning about the whole ACDC given by its top-level SAID, `d`, field, as well as reasoning about any nested sections using their SAIDs.

### Registry SAID field

When present, the registry SAID, `rd` field value is the SAID of the initializing event for a given transaction event log (TEL) registry that maintains a dynamic state for the ACDC, such as issuance and revocation state. 


### Universally unique identifier (UUID) fields

The purpose of the UUID, `u`, field in any block is to provide sufficient entropy to the SAID, `d`, field of the associated block to make computationally infeasible any brute force attacks on that block that attempt to discover the block contents from the schema and the SAID. The UUID, `u`, field may be considered a salty nonce [[29]]. Without the entropy provided the UUID, `u`, field, an adversary may be able to reconstruct the block contents merely from the SAID of the block and the [[ref: Schema]] of the block using a rainbow or dictionary attack on the set of field values allowed by the Schema [[30]] [[31]]. The effective security level, entropy, or cryptographic strength of the schema-compliant field values may be much less than the cryptographic strength of the SAID digest. Another way of saying this is that the cardinality of the power set of all combinations of allowed field values may be much less than the cryptographic strength of the SAID. Thus, an adversary could successfully discover via brute force the exact block by creating digests of all the elements of the power set which may be small enough to be computationally feasible instead of inverting the SAID itself. Sufficient entropy in the `u` field ensures that the cardinality of the power set allowed by the schema is at least as great as the entropy of the SAID digest algorithm itself.

A UUID, `u` field may optionally appear in any block (field map) at any level of an ACDC. Whenever a block in an ACDC includes a UUID, `u`, field then its associated SAID, `d`, field makes a blinded commitment to the contents of that block. The UUID, `u`, field is the blinding factor. This makes that block securely partially disclosable or even selectively disclosable notwithstanding disclosure of the associated Schema of the block. The block contents can only be discovered given disclosure of the included UUID field. Likewise, when a UUID, `u`, field appears at the top level of an ACDC then that top-level SAID, `d`, field makes a blinded commitment to the contents of the whole ACDC itself. Thus, the whole ACDC, not merely some block within the ACDC, may be disclosed in a privacy-preserving (correlation minimizing).

### Autonomic IDentifier (AID) fields

Some fields, such as the `i`, Issuer identifier field, must each have an [[ref: AID]] as its value. An AID is a fully qualified Self-certifying Identifier (SCID) that follows the KERI protocol [[2]].  An AID is derived from one or more `(public, private)` key pairs using asymmetric or public-key cryptography to create verifiable digital signatures [[52]]. Each AID has a set of one or more Controllers who each control a private key. By virtue of their private key(s), the Controllers may make statements on behalf of the associated AID backed by uniquely verifiable commitments via digital signatures on those statements. Any entity then may verify those signatures using the associated set of public keys. No shared or trusted relationship between the Controllers and Verifiers is required. The verifiable key state for AIDs is established with the KERI protocol [[2]]. The use of AIDs enables ACDCs to be used in a portable but securely attributable, fully decentralized manner in an ecosystem that spans trust domains.

### Namespaced AIDs

Because KERI is agnostic about the namespace for any particular AID, different namespace standards may be used to express KERI AIDs or identifiers derived from AIDs as the value of these AID related fields in an ACDC. Some of the examples below use the W3C DID namespace specification with the `did:keri` method [[ref: DIDK_ID]. However, the examples would have the same validity from a KERI perspective if some other supported namespace was used or no namespace was used at all. The latter case consists of a bare KERI AID (identifier prefix) expressed in CESR format [[1]].

### Attribute field

The top-level Attribute section `a`, field value may have as its value a nested field map. Each level of nesting may be fully expanded or represented by its SAID. When present, the `a` field value provides the so-called payload data of the ACDC. The `a` field syntax is described in more detail below. An ACDC shall not have both an `a` field and an `A` field (see next section) when it has either.

### Selectively disclosable Attribute aggregate field

The top-level selectively disclosable Attribute aggregate section, `A`, field value is an aggregate of cryptographic commitments used to make a commitment to a set (bundle) of selectively disclosable Attributes. The value of the Attribute aggregate, `A`, field depends on the type of Selective Disclosure mechanism employed. For example, the aggregate value could be the cryptographic digest of the concatenation of an ordered set of cryptographic digests, a Merkle tree root digest of an ordered set of cryptographic digests, or a cryptographic accumulator. The Selective Disclosure mechanisms are described in detail in the Selective Disclosure section. When present, the `A` field value provides the so-called payload data of the ACDC. The `A` field syntax is described in more detail below. An ACDC shall not have both an `a` field and an `A` field (see next section) when it has either.


### Edge field

The top-level Edge section `e` field value makes a cryptographically verifiable commitment to other ACDCs via references to their SAIDs. The `e` field syntax is described in more detail below.

### Rule field

The top-level Rule section `r`, field value provides both human and machine readable legal language that may be associated with the ACDC. This is a type of Ricardian contract. The `r` field syntax is described in more detail below.


### Field ordering

The ordering of the top-level fields when present in an ACDC must be as follows, `v`, `d`, `u`, `i`, `rd`, `s`, `a`, `A`, `e`, `r`.

