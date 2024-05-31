## Top-level ACDC sections
<!-- file name: top-level-acdc-sections.md -->
### Schema section

#### Type-is-schema

Notable is the fact that no top-level type fields exist in an ACDC. This is because the [[ref: Schema]], `s`, field itself is the type field for the ACDC and its parts. ACDCs follow the design principle of separation of concerns between a data container's actual payload information and the type information of that container's payload. In this sense, type information is metadata, not data. The Schema dialect used by ACDCs is JSON Schema 2020-12 [[10]] [[11]]. JSON Schema supports composable schema (subschema), conditional Schema (subschema), and regular expressions in the Schema. Composability enables a Validator to ask and answer complex questions about the type of even optional payload elements while maintaining isolation between payload information and type (structure) information about the payload [[39]] [[40]] [[41]] [[42]]. A static but composed schema allows a verifiably immutable set of variants. Although the set is immutable, the variants enable graduated but secure disclosure. ACDC's use of JSON Schema must be in accordance with the ACDC defined profile as defined herein. The exceptions are defined below.

#### Schema ID field label

The usual field label for SAID fields in ACDCs is `d`. In the case of the [[ref: Schema]] section, however, the field label for the SAID of the Schema section is `$id`. This repurposes the Schema id field label, `$id` as defined by JSON Schema [[41]] [[42]].  The top-level id, `$id`, field value in a JSON Schema provides a unique identifier of the Schema instance. In a non-ACDC schema, the value of the id, `$id`, field is expressed as a URI. This is called the Base URI of the schema. In an ACDC schema, however, the top-level id, `$id`, field value is repurposed. This field value must include the SAID of the schema. This ensures that the ACDC Schema is static and verifiable to their SAIDs. A verifiably static Schema satisfies one of the essential security properties of ACDCs as discussed below. There are several ACDC supported formats for the value of the top-level id, `$id`, field but all of the formats must include the SAID of the Schema (see below). Correspondingly, the value of the top-level schema, `s`, field must be the SAID included in the schema's top-level `$id` field. The detailed schema is either attached or cached and maybe discovered via its SAIDified id, `$id`, field value.

The digest algorithm employed for generating [[ref: Schema]] SAIDs shall have an approximate cryptographic strength of 128 bits. The [[3]] MUST be generated in compliance with the ToIP SAID internet draft specification and MUST be encoded using CESR. The CESR encoding indicates the type of cryptographic digest used to generate the SAID. 

When an id, `$id`, field appears in a subschema, it indicates a bundled subschema called a schema resource [[41]] [[42]]. The value of the id, `$id`, field in any ACDC bundled subschema resource must include the SAID of that subschema using one of the formats described below. The subschema so bundled must be verifiable against its referenced and embedded SAID value. This ensures secure bundling.

#### Static (immutable) schema

For security reasons, the full Schema of an ACDC must be completely self-contained and statically fixed (immutable) for that ACDC meaning that no dynamic Schema references or dynamic Schema generation mechanisms are allowed.

Should an adversary successfully attack the source that provides the dynamic Schema resource and change the result provided by that reference, then the Schema validation on any ACDC that uses that dynamic Schema reference may fail. Such an attack effectively revokes all the ACDCs that use that dynamic Schema reference, which is called a Schema revocation attack.

More insidiously, an attacker could shift the semantics of the dynamic Schema in such a way that although the ACDC still passes its Schema validation, the behavior of the downstream processing of that ACDC is changed by the semantic shift. This type of attack is called a semantic malleability attack which may be considered a new type of transaction malleability attack [[55]].

To prevent both forms of attack, all Schema must be static, i.e., Schema must be SADs and therefore verifiable against their SAIDs.

To elaborate, the serialization of a static schema may be self-contained. A compact commitment to the detailed static Schema may be provided by its SAID. In other words, the SAID of a static Schema is a verifiable cryptographic identifier for its SAD. Therefore, all ACDC compliant Schema must be SADs. In other words, the Schema must therefore be SAIDified. The associated detailed static Schema (uncompacted SAD) is bound cryptographically and verifiable to its SAID.

The JSON Schema specification allows complex Schema references that may include non-local URI references [[41]] [[42]] [[15]] [[16]]. These references may use the `$id` or `$ref` keywords. A relative URI reference provided by a `$ref` keyword is resolved against the Base URI provided by the top-level `$id` field. When this top-level Base URI is non-local, then all relative `$ref` references are therefore also non-local. A non-local URI reference provided by a `$ref` keyword may be resolved without reference to the Base URI.

In general, Schema indicated by non-local URI references (`$id` or `$ref`) must not be used because they are not cryptographically end-verifiable. The value of the underlying Schema resource so referenced may change (mutate). To restate, a non-local URI Schema resource is not end-verifiable to its URI reference because there is no cryptographic binding between URI and resource [[15]] [[16]].

This does not preclude the use of remotely cached SAIDified Schema resources because those resources are end-verifiable to their embedded SAID references. Said another way, a SAIDified Schema resource is itself a SAD referenced by its SAID. A URI that includes a SAID may be used to securely reference a remote or distributed SAIDified schema resource because that resource is fixed (immutable, nonmalleable) and verifiable to both the SAID in the reference and the embedded SAID in the resource so referenced. To elaborate, a non-local URI reference that includes an embedded cryptographic commitment such as a SAID is verifiable to the underlying resource when that resource is a SAD. This applies to JSON Schema as a whole as well as bundled subschema resources.

The ACDC supported formats for the value of the top-level id, `$id`, field are as follows:

Bare SAIDs may be used to refer to a SAIDified Schema as long as the JSON Schema validator supports bare SAID references. By default, many if not all JSON Schema Validators support bare strings (non-URIs) for the Base URI provided by the top-level `$id` field value.

-	The `sad:` URI scheme may be used to directly indicate a URI resource that safely returns a verifiable SAD. For example, `sad:SAID` where SAID is replaced with the actual SAID of a SAD that provides a verifiable non-local reference to JSON Schema as indicated by the media-type of `schema+json`.

-	The KERI OOBI specification provides a URL syntax that references a SAD resource by its SAID at the service endpoint indicated by that URL [[4]]. Such remote OOBI URLs are also safe because the provided SAD resource is verifiable against the SAID in the OOBI URL. Therefore, OOBI URLs are also acceptable non-local URI references for JSON Schema [[4]] [[15]] [[16]].

-	The `did:` URI scheme may be used safely to prefix non-local URI references that act to namespace SAIDs expressed as DID URIs or DID URLs.  DID resolvers resolve DID URLs for a given DID method such as `did:keri` [[5]] and may return DID docs or DID doc metadata with SAIDified schema or service endpoints that return SAIDified schema or OOBIs that return SAIDified schema [[15]] [[16]] [[4]]. A verifiable non-local reference in the form of DID URL that includes the schema SAID is resolved safely when it dereferences to the SAD of that SAID. For example, the resolution result returns an ACDC JSON Schema whose id, `$id`, field includes the SAID and returns a resource with JSON Schema mime-type of `schema+json`.

To clarify, ACDCs must not use complex JSON Schema references which allow dynamically generated Schema resources to be obtained from online JSON Schema Libraries [[41]] [[42]]. The latter approach may be difficult or impossible to secure because a cryptographic commitment to the base Schema that includes complex Schema (non-relative URI-based) references only commits to the non-relative URI reference and not to the actual schema resource which may change (is dynamic, mutable, malleable). To restate, this approach is insecure because a cryptographic commitment to a complex (non-relative URI-based) reference is not equivalent to a commitment to the detailed associated Schema resource so referenced if it may change.

ACDCs must use static JSON Schema (i.e., SAIDifiable Schema). These may include internal relative references to other parts of a fully self-contained static (SAIDified) Schema or references to static (SAIDified) external Schema parts. As indicated above, these references may be bare SAIDs, DID URIs or URLs (`did:` scheme), SAD URIs (`sad:` scheme), or OOBI URLs [[4]]. Recall that a commitment to a SAID with sufficient collision resistance makes an equivalent secure commitment to its encapsulating block SAD. Thus, static schema may be either fully self-contained or distributed in parts but the value of any reference to a part must be verifiably static (immutable, nonmalleable) by virtue of either being relative to the self-contained whole or being referenced by its SAID. The static schema in whole or in parts may be attached to the ACDC itself or provided via a highly available cache or data store. To restate, this approach is securely end-verifiable (zero-trust) because a cryptographic commitment to the SAID of a SAIDified schema is equivalent to a commitment to the detailed associated schema itself (SAD).

#### Schema dialect

The Schema dialect for ACDC 1.0 is JSON Schema 2020-12 and is indicated by the identifier `"https://json-schema.org/draft/2020-12/schema"`  [[10]] [[11]]. This is indicated in a JSON Schema via the value of the top-level `$schema` field. Although the value of `$schema` is expressed as a URI, de-referencing does not provide dynamically downloadable schema dialect validation code. This would be an attack vector. The Validator must control the tooling code dialect used for Schema validation and hence the tooling dialect version actually used. A mismatch between the supported tooling code dialect version and the `$schema` string value should cause the validation to fail. The string is simply an identifier that communicates the intended dialect to be processed by the Schema validation tool. When provided, the top-level `$schema` field value for ACDC version 1.0 must be "https://json-schema.org/draft/2020-12/schema".

#### Schema versioning

Each schema shall have at the top level version field with field label `version`. The value of the `version` field shall be a semantic version string in the dotted decimal notation of the form "major.minor.patch" . For example, "1.2.3" has a major version number of 1, a minor version number of 2, and a patch version of 3. This value is informative. The `version` field value is not used in the JSON Schema validation against the ACDC. Therefore, a given ACDC may properly pass JSON Schema validation process regardless of the value of its schema `version` field. [[ref: SEMVER]]

Recall that the value of the Schema ID, `$id` field in an ACDC Schema is a SAID which provides an encoded agile cryptographic digest of the contents of the schema. Any change to the schema, including a change to its `version` field, results in a new SAID. Any copy of a schema that verifies against the same SAID given by the Schema ID, `$id` field value can be assumed to be identical to any other copy that verifies to the same SAID by virtue of the strong collision resistance of the digest employed.

This gives rise to two meanings of the word "version" when applied to an ACDC's Schema. One is the version given by the value of its `$id` field, and the other is the version given by its `version` field. The version provided by the `$id` field is cryptographically verifiable. Whereas the version provided by the `version` field is not. Thus, the latter is an informative indication of the version, and the former is a normative determiner of the version. In this sense, the Schema ID, `$id` field value as a SAID provides a cryptographically verifiable version indicator independent of the version field value. To avoid confusion, any change to the Schema that changes the value of the `$id` shall also be reflected in a correspondingly unique value of its `version` field. Business logic may depend on consistency between the `version` field value with respect to the `$id` field value. Notwithstanding the actual value of the `version` field, the `$id` field value is the normative determiner of the Schema's true, verifiable version.

The JSON Schema for an ACDC may use composition operators (see below). This allows extensibility in schema such that, in some cases, ACDCs with newer Schema versions may be backward (in)compatible with older schema versions. A new schema version, as given by the `$id` field value, is considered backward incompatible with respect to a previous version of a Schema when any instance of an ACDC that validates (in the JSON Schema sense of validation) against the previous version of the Schema may not be guaranteed to validate against the new version. Because any change to the `version` field value results in a different `$id` field value, the backward compatibility rule also applies changes in the `version` field value. To comply with the semantic versioning rules, a backward incompatible Schema shall have a higher major version number in its `version` field value than any backward incompatible version.

One complication with schema versioning arises when an ACDC has Edges. As discussed below in the Edge section, an Edge block may have a Schema, `s` field, which indicates that the ACDC node the edge points to must validate against the schema indicated by the Edge's Schema, `s` field value. Consequently, the version of the Edge's schema `s` field value may differ from the version of the Schema `s` field value in the ACDC node pointed to by that edge. If both schemas validate, then the Edge's schema version is backward compatible with the ACDC's schema version (node pointed to by the Edge). This means the Edge's schema version may have a higher minor version number than the ACDC's schema version (node pointed to by the Edge). If the Edge's schema does not validate against the ACDC node pointed to by the edge, then the Edge's schema is backward incompatible and shall have a higher major version number than the ACDC's schema (node pointed to by the edge).  In this latter case, ACDCs issued under the old major version must either be revoked and reissued to comply with the new major version schema, or the Edge's schema must include a `oneOf` composition that accepts either old or new major versions. In general, this would lead to extending that list of `oneOf`s in that Edge's schema field value to include an entry for each major version change.

#### Schema availability

The composed detailed (uncompacted) (bundled) static Schema for an ACDC may be cached or attached. But cached, and/or attached static Schema is not to be confused with dynamic Schema. Nonetheless, while securely verifiable, a remotely cached, SAIDified, Schema resource may be unavailable. Availability is a separate concern. Unavailable does not mean insecure or unverifiable. ACDCs must be verifiable when available.  Availability is typically solvable through redundancy. Although a given ACDC application domain or ecosystem governance framework (EGF) may impose schema availability constraints, this ACDC specification itself does not impose any specific availability requirements on Issuers other than schema caches should be sufficiently available for the intended application of their associated ACDCs. It is up to the Issuer of an ACDC to satisfy any availability constraints on its Schema that may be imposed by the application domain or ecosystem.

#### Composable JSON Schema

A composable JSON Schema enables the use of any combination of compacted/uncompacted Attribute, Edge, and Rule sections in a provided ACDC. When compact, any one of these sections may be represented merely by its SAID [[10]] [[39]]. When used for the top-level attribute, `a`, edge, `e`, or rule, `r`, section field values, the `oneOf` subschema composition operator provides both compact and uncompacted variants. The provided ACDC must validate against an allowed combination of the composed variants. The Validator determines what decomposed variants the provided ACDC must also validate against. Decomposed variants may be dependent on the type of Graduated Disclosure. Essentially, a composable schema is a verifiable bundle of metadata (composed) about content that can then be verifiably unbundled (decomposed) later. The Issuer makes a single verifiable commitment to the bundle (composed Schema), and a recipient may then safely unbundle (decompose) the schema to validate any of the Graduated disclosure variants allowed by the composition.

Unlike the other compactifiable sections, it is impossible to define recursively the exact detailed schema as a variant of a `oneOf` composition operator contained in itself.  Nonetheless, the provided schema, whether self-contained, attached, or cached must validate as a SAD against its provided SAID. It also must validate against one of its specified `oneOf` variants. Typically, it's SAID or a generic object.

The compliance of the provided non-schema attribute, `a`, edge, `e`, and rule, `r`, sections must be enforced by validating against the composed Schema. In contrast, the compliance of the provided composed schema for an expected ACDC type must be enforced by the Validator. This is because it is not possible to enforce strict compliance of the schema by validating it against itself.

ACDC-specific Schema compliance requirements usually are specified in the EGF for a given ACDC type.  Because the SAID of a Schema is a unique content-addressable identifier of the Schema itself, compliance can be enforced by comparison to the allowed schema SAID in a well-known publication or registry of ACDC types for a EGF. The EGF may be specified solely by the Issuer for the ACDCs it generates or be specified by some mutually agreed upon ecosystem governance mechanism. Typically, the business logic for making a decision about a presentation of an ACDC starts by specifying the SAID of the composed Schema for the ACDC type that the business logic is expecting from the presentation. The verified SAID of the actually presented Schema is then compared against the expected SAID. If they match, then the actually presented ACDC may be validated against any desired decomposition of the expected (composed) Schema.

To elaborate, a Validator can confirm compliance of any non-schema section of the ACDC against its Schema both before and after uncompacted disclosure of that section by using a composed base Schema with `oneOf` pre-disclosure and a decomposed Schema post-disclosure with the compact `oneOf` option removed. This capability provides a mechanism for secure Schema validation of both Compact and uncompacted variants that require the Issuer to only commit to the composed Schema and not to all the different Schema variants for each combination of a given compact/uncompacted section in an ACDC.

One of the most important features of ACDCs is support for Chain-Link Confidentiality [[44]. This provides a powerful mechanism for protecting against unpermissioned exploitation of the data disclosed via an ACDC. Essentially, an exchange of information compatible with Chain-Link Confidentiality starts with an offer by the Discloser to disclose confidential information to a potential Disclosee. This offer includes sufficient metadata about the information to be disclosed such that the Disclosee can agree to those terms. Specifically, the metadata includes both the schema of the information to be disclosed and the terms of use of that data once disclosed. Once the Disclosee has accepted the terms, then Full disclosure is made. A Full Disclosure that happens after contractual acceptance of the terms of use is called permissioned disclosure. The pre-acceptance disclosure of metadata is a form of Partial Disclosure.

As is the case for Compact (uncompacted) ACDC disclosure, composable JSON Schema enables the use of the same base Schema for both the validation of the Partial disclosure of the offer metadata prior to contract acceptance and validation of full or detailed disclosure after contract acceptance [[10]][[39]]. A cryptographic commitment to the base schema securely specifies the allowable semantics for both Partial and Full Disclosure. Decomposition of the base Schema enables a Validator to impose more specific semantics at later stages of the exchange process. Specifically, the `oneOf` subschema composition operator validates against either the compact SAID of a block or the full block. Decomposing the schema to remove the optional Compact variant enables a Validator to ensure complaint Full Disclosure. To clarify, a Validator can confirm Schema compliance both before and after detailed disclosure by using a composed base Schema pre-disclosure and a decomposed schema post-disclosure with the undisclosed options removed. These features provide a mechanism for secure schema-validated contractually-bound Partial (and/or Selective) Disclosure of confidential data via ACDCs.

### Attribute section

#### Reserved field labels

The following field labels are reserved at all nested field map levels in the Attribute section of an ACDC.
 
| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Identifier (AID)| Context-dependent AID as determined by its enclosing map such as Issuee identifier. |
|`dt`| Datetime | Issuer's relative ISO datetime string |

##### Datetime, `dt` field
The datetime, `dt` field value, if any, shall be the ISO-8601 datetime string with microseconds and UTC offset as per IETF RFC-3339. This datetime is relative to the clock of the issuer. Attributes typically include one or more date time fields. In a given field map (block) the primary datetime will use the label, `dt`. Typically, this is the datetime of the issuance of the ACDC. Other datetime fields may include an expiration datetime or the like.

 An example datetime string in this format is as follows:

`2020-08-22T17:50:09.988921+00:00`


#### Compact attribute section schema

When the value of the  Attribute section has been compacted into its SAID, its Schema is as follows: 

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

Two variants, namely, Targeted (Untargeted), are defined respectively by the presence (absence) of an Issuee, `i` field at the top-level of the uncompacted Attribute section block.

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

To elaborate, the definition of the term credential is "evidence of authority, status, rights, entitlement to privileges, or the like". The presence of an attribute section top-level Issuee, `i`, field enables the ACDC to be used as a Verifiable Credential given by the Issuer to the Issuee.

One reason the Issuee, `i`, field is nested into the Attribute section, `a`, block is to enable the Issuee AID to be partially or selectively disclosable. Because the actual semantics of Issuee may depend on the use case, the semantically precise albeit less common terms of Issuer and Issuee are used in this specification. In some use cases, for example, an Issuee may be called the Holder; in others, the Subject of the ACDC. But no matter the use case, the `i` field designates the Issuee AID, i.e. Target. The ACDC is "issued by" an Issuer and is "issued to" an Issuee. This precise terminology does not bias or color the role (function) that an Issuee plays in using an ACDC. What the presence of Issuee AID does provide is a mechanism for control of the subsequent use of the ACDC once it has been issued. To elaborate, because the Issuee, `i`, field value is an AID, by definition, there is a provable Controller of that AID. Therefore, the Issuee Controller may make non-repudiable commitments via digital signatures on behalf of its AID.  Therefore, subsequent use of the ACDC by the Issuee may be securely attributed to the Issuee.

Importantly, the presence of an Issuee, `i`, field enables the associated Issuee to make authoritative verifiable presentations or disclosures of the ACDC. A designated Issuee also better enables the initiation of presentation exchanges of the ACDC between that Issuee as Discloser and a Disclosee (Verifier).

In addition, because the Issuee is a specified counterparty, the Issuer may engage in a contract with the Issuee that the Issuee agrees to by virtue of its non-repudiable signature on an offer of the ACDC prior to its issuance. This agreement may be a pre-condition to the issuance and thereby impose liability waivers or other terms of use on that Issuee. 

Likewise, the presence of an Issuee, `i`, field enables the Issuer to use the ACDC as a contractual vehicle for conveying authorization to the Issuee.  This enables verifiable delegation chains of authority because the Issuee in one ACDC may become the Issuer of another ACDC. Thereby, an Issuer may delegate authority to an Issuee who may then become a verifiably authorized Issuer that then delegates that authority (or attenuation of that authority) to some other verifiably authorized Issuee and so forth.

Contractual issuance and presentation exchanges are described in detail later in the IPEX protocol section {{reference to IPEX section}}.

:::issue
:::

##### Untargeted Attribute section

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

This ACDC has an Issuer but no Issuee. There is no provably controllable AID as a Target of the issuance, i.e., Untargeted. The data in the Attribute section may be considered an undirected verifiable attestation or observation by the Issuer.  The attestation is addressed "to whom it may concern." An Untargeted ACDC enables verifiable authorship by the Issuer of the data in the Attributes section, but there is no specified counterparty and no verifiable mechanism for delegation of authority.  Consequently, the Rules section may provide only contractual obligations of implied counterparties.

This form of an ACDC provides a container for authentic data only (not authentic data as authorization). But authentic data is still a very important use case. To clarify, an Untargeted ACDC enables verifiable authorship of data. An observer, such as a sensor that controls an AID, may make verifiable, nonrepudiable measurements and publish them as ACDCs. These may be chained together to provide provenance for or a chain-of-custody of any data.  Furthermore, a hybrid chain of one or more targeted ACDCs ending in a chain of one or more Untargeted ACDCs enables delegated authorized attestations at the tail of that chain. These provenanceable chains of ACDCs could be used to provide a verifiable data supply chain for any compliance-regulated application. This provides a way to protect participants in a supply chain from imposters. Such data supply chains are also useful as a verifiable digital twin of a physical supply chain [[54]].


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

As described above in the Schema section of this specification, the `oneOf` subschema composition operator validates against either the compact SAID of a block or the full block. A Validator can use a composed Schema that has been committed to by the Issuer to securely confirm Schema compliance both before and after detailed disclosure by using the fully composed base Schema pre-disclosure and a specific decomposed variant post-disclosure. Decomposing the Schema to remove the optional compact variant (i.e., removing the `oneOf` compact option) enables a Validator to ensure compliant Full Disclosure. To clarify, using the JSON Schema `oneOf` composition Operator enables the composed subschema to validate against both the compact and un-compacted value of the private-attribute section, `a`, field.

As discussed above, the presence of the `i` field at the top level of the Attribute section block makes this a targeted Attribute section. The AID given by the `i` field value is the target entity called the Issuee. The semantics of the Issuee maybe defined by the Credential Frameworks in the EGF.

Given the presence of a top-level UUID, `u`, field of the Attribute block whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of the Attribute block provides a secure cryptographic digest of the contents of the Attribute block [[48]]. An adversary when given both the Schema of the Attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the attribute block in a computationally feasible manner such as a rainbow table attack [[30]] ] [[31]].  Therefore, the attribute block's UUID, `u`, field in a compact ACDC enables its Attribute block's SAID, `d`, field to securely blind the contents of the Attribute block notwithstanding knowledge of the Attribute block's Schema and SAID, `d` field.  Moreover, a cryptographic commitment to that Attribute block's, SAID, `d`, field does not provide a fixed point of correlation to the Attribute field values themselves unless and until there has been a disclosure of those field values.

To elaborate, when an ACDC includes a sufficiently high entropy UUID, `u`, field at the top level of its Attributes block then the ACDC may be considered a private-attributes ACDC when expressed in compact form, that is, the Attribute block is represented by its SAID, `d`, field and the value of its top-level Attribute section, `a`, field is the value of the nested SAID, `d`, field from the uncompacted version of the Attribute block. A verifiable commitment may be made to the compact form of the ACDC without leaking details of the Attributes. Later disclosure of the uncompacted Attribute block may be verified against its SAID, `d`, field that was provided in the compact form as the value of the top-level Attribute section, `a`, field.

Because the Issuee AID is nested in the attribute block as that block's top-level, Issuee, `i`, field, a presentation exchange (disclosure) could be initiated on behalf of a different AID that has not yet been correlated to the Issuee AID and then only correlated to the Issuee AID after the Disclosee has agreed to the Chain-Link Confidentiality provisions in the rules section of the private-attributes ACDC [[44].

#### Targeted public-attribute section example

Suppose that the un-compacted value of the Attribute section as denoted by the Attribute section, `a`, field is as follows,

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

As described above in the Schema section of this specification, the `oneOf` subschema composition operator validates against either the compact SAID of a block or the full block. A Validator can use a composed Schema that has been committed to by the Issuer to securely confirm Schema compliance both before and after detailed disclosure by using the fully composed base Schema pre-disclosure and a specific decomposed variant post-disclosure. Decomposing the Schema to remove the optional compact variant (i.e., removing the `oneOf` compact option) enables a Validator to ensure compliant Full Disclosure. To clarify, using the JSON Schema `oneOf` composition Operator enables the composed subschema to validate against both the compact and un-compacted value of the public-attribute section, `a`, field.

The SAID, `d`, field at the top level of the uncompacted Attribute block is the same SAID used as the compacted value of the Attribute section, `a`, field.

As discussed above, the presence of the `i` field at the top level of the Attribute section block makes this a targeted Attribute section. The AID given by the `i` field value is the Target or Issuee. The semantics of the issuance may be defined by the Credential Frameworks of the EGF.

Given the absence of a `u` field at the top level of the Attributes block, however, knowledge of both SAID, `d`, field at the top level of an Attributes block and the schema of the Attributes block may enable the discovery of the remaining contents of the attributes block via a rainbow table attack [[30]] [[31]]. Therefore, the SAID, `d`, field of the Attributes block, although a cryptographic digest, does not securely blind the contents of the Attributes block given knowledge of the Schema. It only provides compactness, not privacy. Moreover, any cryptographic commitment to that SAID, `d`, field potentially provides a fixed correlation point to the attribute block field values despite the non-disclosure of those field values via a Compact Attribute section. Thus, an ACDC without a UUID, `u` field in its Attributes block must be considered a Public-Attribute ACDC even when expressed in compact form.

#### Nested partially disclosable Attribute section example

Suppose that the un-compacted value of the Attribute section of an ACDC is as follows:

Attribute section:

```json
{
  "a":
  {
    "d": "EBf7V_NHwY1lkFrn9y2PYgveY4-9XgOcLxUderzwLIr9",
    "u": "0ADAE0qHcgNghkDaG7OY1wja",
    "i": "EFv7vklXKhzBrAqjsKAn2EDIPmkPreYApZfFk66jpf3u",
    "name": "Jane Doe",
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
                  "u":
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

The Attribute section subschema includes a `oneOf` composition operator at the grades subblock. The `grades` subblock has both a block level SAID, `d` and UUID, `u` field. This means that the `grades` subblock detail can be hidden so that only the top-level fields in the Attribute section are disclosed. The following shows a compatible partially disclosed variant of the Attribute section.

Partially disclosed Attribute section:

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

Notice that the compact form of the `grades` subblock has as the field value of the `grades` field the value of the SAID, `d` field in the expanded version (see above). This means that when the subblock detail is provided, a Validator can verify it against the SAID provided in the compact (partially disclosed) form.

### Edge section  

The Edge Section, `e` field appears as a top-level block within the ACDC and denotes the start of subsequent Edge-groups. The Edge Section has several reserved fields that may appear as top-level fields within its block.

#### Block types

There are two types of field maps or blocks that may appear as values of fields within the Edge Section, `e` field either at the top level of the Edge block itself or nested. These are Edges or Edge-groups. Edges may only appear as locally unique labeled (using non-reserved labels) blocks nested within an Edge-group. There are two exceptions for Edges, compact and simple compact form. In these two forms the Edge field value is not a block but a string. These exceptions are defined below.

Nested Edge-groups may only appear as locally unique labeled blocks nested within another Edge-group. The block type, Edge or Edge-group, is indicated by its corresponding labeled subschema, with the exception of the top-level Edge-group, which is the Edge Section and is indicated by the Edge Section subschema. An Edge is indicated by the required presence of a node, `n` field in the non-compact variant of its subschema. An Edge-group shall not have a node, `n` field.

#### ACDCs as secure graph fragments of a globally distributed property graph (PG)

A set of ACDCs as nodes connected by edges forms a labeled property graph (LPG) or property graph (PG) for short [[56]] [[57]] [[58]]. Property graphs have properties not only in the nodes but also in the edges. The properties of each node (ACDC) are provided essentially by its Attribute Section. The properties of each edge are provided by the combination of Edge blocks and Edge-group blocks. In this regard, the set of nested Edge-groups within a given top-level Edge Section, i.e., the `e` field block of a given ACDC, constitute a sub-graph of a super-graph of ACDCs where the nodes of the super-graph are ACDCs. The nodes of the sub-graph are the Edge-groups and Edges, not whole ACDCs. One of the attractive features of property graphs (PGs) is their support for different edge and node types, which enables nested sub-graphs that support the rich expression of complex logical or aggregative operations on groups of Edges and/or Edge-groups (as subnodes) within the top-level Edge Section, `e`, field of an ACDC (as supernode).

To clarify, the Edge Section of an ACDC forms a sub-graph where each Edge block is a leaf of a branch in that sub-graph that terminates at the value of its node, `n`, field. Its node, `n` field, points to some other ACDC that is itself a sub-graph. The head of each sub-graph is the top-level Edge-group, i.e. the Edge Section. Thus, an Edge block is a leaf with respect to the sub-graph formed by any nested Edge-group blocks in which the Edge appears.  

Abstractly, an ACDC with one or more edges may be viewed as a fragment of a larger distributed property graph where each ACDC Edge Section is a sub-graph. Each node in this larger graph is universally uniquely identified by the SAID of its ACDC. Recall that a SAID is a cryptographic digest. The local labels on each Edge block or Edge-group block are not universally uniquely resolvable, so they are inappropriate as a verifiable hook for resolving the Edges in a globally distributed property graph. This requires resolving both nodes and Edges. To enable both the node and its connecting edge to be globally uniquely resolvable, each Edge's block must also have a SAID, `d`, field. Recall that a SAID is a cryptographic digest. Therefore, it will universally and uniquely identify an Edge with a given set of properties [[48]], including the node it points to. 

Thus, a given ACDC with its Edges may be universally uniquely resolvable as a graph fragment of a larger graph.  Moreover, because each ACDC with edges, i.e., a graph fragment, may be independently sourced and securely attributed, a distributed property graph can be securely assembled and verified fragment by fragment. To summarize, these features enable ACDCs to be used as securely attributed fragments of a globally distributed property graph (PG). This further enables such a property graph so assembled to serve as a global verifiable knowledge graph that crosses trust domains [[56]] [[57]] [[58]]. 

The universal uniqueness of the ACDC SAIDs (nodes) and their Edge SAIDs enable the simplified discovery of ACDCs via service endpoints. The discovery of a service endpoint URL that provides database access to a copy of the ACDC may be bootstrapped via an OOBI (Out-Of-Band-Introduction) that links the service endpoint URL to the SAID of the ACDC or by the SAID of the Edge that points to the SAID of that ACDC [[4]]. Alternatively, the Issuer may provide as an attachment at the time of issuance a copy of the referenced ACDC. In either case, after a successful exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced ACDCs as nodes in the edge sections of all referenced ACDCs. That Issuee will then have everything it needs to make a successful disclosure to some other Disclosee. This is the essence of Percolated Discovery [[4]].

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

The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Edge-group block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [@Hash]. An adversary, when given both the block's subschema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [@RB][@DRB].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's subschema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Operator, `o` field

The Operator, `o` field must appear immediately following the SAID, `d` field, and UUID, `u` field (when present) in the Edge-group block. The Operator field in an Edge-group block is an aggregating (m-ary) operator on all the nested labeled Edges or Edge-groups that appear in its block. This differs from the Operator, `o` field in an Edge block (see below).

The m-ary operators are defined in the table below:

| M-ary Operator | Description | Default|
|:-:|:--|:--|:--|
|`AND`| Logical AND of the validity of the Edge-group members. Edge-group is valid only if all members are valid. | Yes |
|`OR`| Logical OR of the validity of the Edge-group members. Edge-group is valid if one of the members is valid. | No |
|`NAND`| Logical NAND of the validity of the Edge-group members. Edge-group is valid only if not all members are valid. | No |
|`NOR`| Logical NOR of the validity of the Edge-group members. Edge-group is valid only if all members are invalid. | No |
|`AVG`| Arithmetic average of a given Edge-group member property. Averaged property is defined by the schema or EGF. | No |
|`WAVG`| Weighted arithmetic average of a given Edge-group member property. Weight is given by the `w` field. Averaged property is defined by the Schema or EGF. | No |

When the Operator, `o`, field is missing in an Edge-group block, the default value for the Operator, `o`, field shall be the `AND` Operator.

The actual logic for interpreting the validity of a set of chained or treed ACDCs is EGF-dependent.  But as a default, at least at the time of issuance, a set of chained (treed) ACDCs can be interpreted as a provenance chain (tree) with the default logic explained below. ACDCs in a provenance chain or branch that have expiration dates or are dynamically revocable add a timeliness property to the validation logic in the event that the chain was unbroken at issuance but becomes broken later. The timeliness logic is EGF-dependent. 

When the top-level Edge-group, the Edge Section includes only one Edge, the logic for evaluating the validity of the enclosing ACDC (near node) with respect to the validity of the connected far node ACDC pointed to by that edge may be considered a link in a provenance chain.  When any node in a provenance chain is invalid, an Edge pointing to that node is also invalid. If a node has an invalid Edge, then the node is invalid.  To elaborate, a chain of nodes with Edges has a head and a tail. The Edges are directed from the head to the tail. All links from the node at the head at one end of a chain to the tail at the other end must be valid in order for the node (head) to be valid. If any links between the head and the tail are broken (invalid), then the head is itself invalid. The unary operators (defined below) for edges enable modulation of the validation logic of a given Edge/node in a chain of ACDCs.

When the top-level Edge-group, the Edge Section includes more than one Edge directly or indirectly (as nested Edge(s) in nested Edge-group), then the logic for evaluating the validity of the enclosing ACDC (near node) with respect to the validity of all the connected far node ACDCs pointed to by those Edges may be a provenance tree.  Instead of a single chain from the head to a single tail, there is a tree with the truck at the head and branches as chains of directed Edges that each point to a branch tail (leaf) node. To clarify, each branch is a chain from head to branch tail.  All branches from the head must be valid for the head node to be valid. The m-ary Operators (defined above), in combination with the unary Operators (defined below), allow modulation of the validation aggregation logic of groups of Edges/nodes at each branch in a tree of ACDCs.

##### Weight, `w` field

The Weight, `w` field must appear immediately following all of the SAID, `d` field, UUID, `u` field (when present), and Operator, `o` field (when present) in the Edge-group block. The Weight field enables weighted averages with Operators that perform some type of weighted average, such as the `WAVG` Operator. The top-level Edge-group shall not have a weight, `w` field, because it is not a member of another Edge-group.

A Edge-group with a weight provides an aggregate of weighted directed Edges. Weighted directed Edges may represent degrees of confidence or likelihood. PGs with weighted, directed Edges are commonly used for machine learning or reasoning under uncertainty. The Weight, `w` field provides a reserved label for the primary weight on an Edge group to be applied by the Operator of its enclosing Edge-group. To elaborate, many aggregating Operators used for automated reasoning, such as the weighted average, `WAVG`, Operator, or ranking aggregation Operators, depend on each input's weight. To simplify the semantics for such Operators, the Weight, `w`, field is the reserved field label for weighting. Other fields with other labels (labeled Edge-group properties) could provide other types of weights, but having a default label, namely `w`, simplifies the default definitions of weighted Operators.

##### Labeled nested edge and edge-group fields

Edge-groups and Edges nested within a given Edge-group appear as labeled fields whose labels are not any of the reserved field labels for either Edge-groups or Edges, namely, `[d, u, n, s, o, w]'. Labeled nested Edge or Edge-group fields must appear after all of any fields with a reserved field label.

Each nested Edge or Edge-group block within an Edge-group including the top-level Edge Section Edge-group shall be labeled with a locally unique non-reserved field label that indicates the type of the nested block. To clarify, each nested block in every Edge-group gets its own field with its own local (to the ACDC) label. The field's value may be either an Edge sub-block or when in compact form, a string. The compact forms are defined below.

Note that each nested block shall not include a type field. The type of each block is provided by that associated subschema in the Edge Section's subschema with a matching label. This is in accordance with the design principle of ACDCs that may be succinctly expressed as "type-is-schema." This approach varies somewhat from other types of property graphs, which often do not have a Schema [[56]] [[57]] [[58]]. Because ACDCs have a Schema, they leverage it to provide property graph edge types with a cleaner separation of concerns. Notwithstanding this separation, an Edge block may include a constraint on the type of the ACDC to which that Edge points by including the SAID of the schema of the pointed-to ACDC as a property of that edge (see below).  

A main distinguishing feature of a property graph (PG) is that both nodes and Edges may have a set of properties [[56]] [[57]] [[58]]. These might include modifiers that influence how the connected node is to be combined or place a constraint on the allowed type(s) of connected nodes. Each Edge's block provides the Edge's properties vis-a-vis a property graph. Additional properties may be inferred from the properties of an enclosing Edge-group's block. Each labeled Edge and Edge-group type is defined by the subschema designated by its label. 

#### Edge

An Edge is typically represented as a block (field map). There are two exceptions, however, compact Edge form and simple compact Edge form. These are defined below. The Edge subschema is used to differentiate these two compact forms from the block form.

The reserved field labels within an Edge block are defined in the table below.

| Label | Title | Description |
|:-:|:--|:--|
|`d`| Digest (SAID) | Optional, self-referential fully qualified cryptographic digest of enclosing Edge map. |
|`u`| UUID | Optional random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`n`| Node| Required SAID of the far node ACDC as the terminating point of a directed edge that connects the Edge's encapsulating near node ACDC to the specified far node ACDC as a fragment of a distributed property graph (PG).|
|`s`| Schema| Optional SAID of the JSON Schema block of the far node ACDC. |
|`o`| Operator| Optional as either a unary operator on the Edge itself or an m-ary operator on the Edge-group in Edge section. Enables expression of the Edge logic on Edge subgraph.|
|`w`| Weight| Optional edge weight property that enables default property for directed weighted edges and operators that use weights.|

An Edge block shall have a node, `n`, field. This differentiates an Edge block from an Edge-group block.  The SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, and weight, `w`  fields are optional. To clarify, each Edge block shall have a node, `n`, field and  may have any combination of SAID, `d`, UUID, `u`, schema, `s`, operator, `o`, or weight, `w` fields. When present the order of appearance of these fields is as follows: `[d, u, n, s, o, w]'.


##### SAID, `d` field

The SAID, `d` field is optional but, when present, shall appear as the first field in the Edge block. The value of this field shall be the SAID of its enclosing block.

###### Compact edge

Given that an individual edge's property block includes a SAID, `d`, field, a compact representation of the edge's property block is provided by replacing it with its SAID. This is called a compact edge. The schema for that edge's label shall indicate that the edge value is the edge block SAID by using a `oneOf` composition of the compact form and the expanded form. This may be useful for compacting complex edges with many properties and then expanding them later. When the edge block also includes a UUID, `u` field then compating also hides the edge properties for later disclosure. A compact edge without a UUID, `u` field is a public compact edge.  A compact edge with a UUID, `u` field is a private compact edge. 

##### UUID, `u` field

The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Edge block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[48]]. An adversary, when given both the block's subschema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[30]] [[31]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's subschema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

The absence of the UUID, `u` field in an Edge block makes that edge a Public Edge. 
The presence of the UUID, `u` field in an Edge block makes that Edge a Private Edge.  A Private Edge in compact form, i.e., a Compact Private Edge, enables a presenter of that ACDC to make a verifiable commitment to the ACDC attached to the Edge without disclosing any details of that ACDC, including the ACDC's SAID. Private ACDCs (nodes) and Private Edges may be combined to better protect the privacy of the information in a distributed property graph.


##### Node, `n` field

When an Edge block does not include a SAID, `d` field, then the node, `n` field must appear as the first field in the block.

The value of the required node, `n` field, is the SAID of the ACDC to which the Edge connects, i.e., the node, `n` field indicates, designates, references, links, or "points to" another ACDC called the far node. To clarify, the Edge is directed from the near node, i.e., the ACDC in which the Edge block resides, to the far node, which is the ACDC indicated by the value of node, `n` field of that block. The edges and nodes form a directed acyclic graph (DAG). 

In order for a given Edge to be valid, at the very least, a Validator shall confirm that the SAID of the provided far node ACDC matches the node, `n` field value given in the near node ACDC Edge block and shall confirm that the provided far node ACDC satisfies its own schema. When the Edge block has a schema, `s` field is present (see below), then the far node shall also validate against the Schema indicated by the near node Edge's Schema, `s` field value.


###### Simple compact edge

When an Edge sub-block has only one field, that is, its node, `n` field, i.e., it has no other properties, then the Edge block may use an alternate simplified, compact form where the labeled Edge field value is the value of its node, `n,` field. The Edge is, therefore, public.  This enables the very compact expression of simple public Edges. The Schema for that Edge's label shall indicate that the Edge value is a far node SAID string and use a `oneOF` composition whose expanded block has only a Node, `n` field with the far node SAID as its value. 

##### Schema, `s` field

When present, the Schema `s` field must appear immediately following the node `n` field in the Edge sub-block. The schema, `s` field provides an additional constraint on the far node ACDC. The far node ACDC shall also validate against an Edge block schema, `s` field when present.  To clarify, the Validator, after validating that the provided far node ACDC indicated by the node, `n` field satisfies its (the far ACDC's) own Schema, shall also confirm that far node ACDC passes Schema validation with respect to the Edge's `s` field value. This validation is simplified whenever the SAID of the far node ACDC Schema matches the SAID of the Edge's Schema, `s` field because only one Schema validation has to be performed. However, when the Schema SAIDs differ, two Schema validation runs shall be performed. The Edge Schema, `s` field enables a given Issuer of an ACDC to force forward compatibility constraints (i.e. minor schema version changes) on old ACDCs to which a new issuance is chained without having to add each old minor version to a list of `oneOf` compositions in the Edge's Schema, `s` field value. Major version changes are, by definition backwards breaking, so either the old version ACDC's must be revoked and reissued or the new Edge's schema value must include a `oneOf` composition that includes the old major versions. See the discussion under the Schema section for Schema versioning.

##### Operator, `o` field

The Operator, `o` field must appear immediately following the SAID, `d` field, UUID, `u` field, node, `n` field, or schema, `s` field (when present) in the Edge block. The Operator, `o`, field value in an Edge block is a unary Operator on the Edge itself. When more than one unary Operator is applied to a given Edge, then the value of the Operator, `o`, field is a list of those unary Operators. When multiple unary Operators appear in the list, and there is a conflict between Operators, the latest Operator among the conflicting Operators in the list takes precedence. This differs from the Operator, `o` field in an Edge-group block (see above).

The unary operators are defined in the table below:

| Unary Operator | Description | Default|
|:-:|:--|:--|:--|
|`I2I`| Issuer-To-Issuee, The Issuer AID of this ACDC shall be the Issuee AID of the node this Edge points to.  | Yes |
|`NI2I`| Not-Issuer-To-Issuee, The Issuer AID of this ACDC may or may not be the Issuee AID of the node that this Edge points to. |  No |
|`DI2I`| Delegated-Issuer-To-Issuee, The Issuer AID of this ACDC must be either the Issuee AID or a delegated AID of the Issuee AID of the node this Edge points to. | No |
|`NOT`| Logical NOT. The validity of the node this Edge points to is inverted. If valid, then not valid. If invalid, then valid.  | No |

When the Operator, `o`, field is missing or empty or is present but does not include any of the `I2I`, `NI2I` or `DI2I` Operators then:

- If the node pointed to by the Edge is a targeted ACDC, i.e., has an Issuee, then the `I2I` Operator shall be appended to the Operator, `o`, field's effective list value.

- If the node pointed to by the Edge block is an Untargeted ACDC i.e., does not have an Issuee, then the `NI2I` Operator shall be appended to the Operator, `o`, field's effective list value.

Many ACDC chains use Targeted ACDCs (i.e., have Issuees). A chain of Issuer-To-Issuee-To-Issuer Targeted ACDCs in which each Issuee becomes the Issuer of the next ACDC in the chain can be used to provide a chain-of-authority. A common use case of a chain-of-authority is a delegation chain for authorization.

The `I2I` unary operator, when present, means that the Issuer AID of the current ACDC in which the Edge resides must be the Issuee AID of the node to which the Edge points. Therefore, to be valid, the ACDC node pointed to by this Edge shall be a Targeted ACDC. This is the default value when the Operator 'o' field value is missing or empty.

The `NI2I` unary Operator, when present, removes or nullifies any requirement expressed by the `I2I` Operator described above. In other words, any requirement that the Issuer AID of the current ACDC in which the Edge resides must be the Issuee AID, if any, of the node the Edge points to is relaxed (not applicable). To clarify, when operative (present), the `NI2I` Operator means that both an Untargeted ACDC or Targeted ACDC, as the node pointed to by the Edge, may be valid even when Untargeted or if Targeted even when the Issuer of the ACDC in which the Edge appears is not the Issuee AID, of that node to which the Edge points.

The `DI2I` unary Operator, when present, expands the class of allowed Issuer AIDs of the node the Edge resides in to include not only the Issuee AID but also any delegated AIDs of the Issuee of the node to which the Edge points.  Therefore, to be valid, the ACDC node pointed to by this Edge shall be a Targeted ACDC.

The `NOT` unary Operator, when present, inverts the validation truthiness of the node pointed to by this Edge. If this Edge's far node ACDC is invalid, then the presence of the `NOT` operator makes this Edge valid. Conversely, if this Edge's far node ACDC is valid, then the presence of the `NOT` Operator makes this Edge invalid.     

###### Weight, `w` field.

The Weight, `w` field must appear immediately following the SAID, `d` field, UUID, `u` field, Node, `n` field, Schema, `s` field, or Operator, `o` field (when present) in the Edge block. The Weight field enables weighted direct Edges. The weighted directed Edges within an enclosing Edge-group may be aggregated when that Edge-group's Operator performs some type of weighted average.

Weighted directed Edges may represent degrees of confidence or likelihood. PGs with weighted, directed Edges are commonly used for machine learning or reasoning under uncertainty. The Weight, `w` field provides a reserved label for the primary Weight on an Edge. To elaborate, many aggregating operators used for automated reasoning, such as the weighted average, `WAVG`, Operator, or ranking aggregation Operators, depend on each input's Weight. To simplify the semantics for such Operators, the Weight, `w` field is the reserved field label for weighting. Other fields with other labels (labeled Edge properties) could provide other types of weights, but having a default label, namely `w` simplifies the default definitions of weighted Operators.

##### Labeled property fields

Edge property fields appear as labeled fields whose labels are not any of the reserved field labels for either Edge-groups or Edges, namely, `[d, u, n, s, o, w].' Labeled property fields must appear after all of any fields with a reserved field label.



#### Edge Section Examples

Consider four different ACDCs in compact form (see below). The Issuer of the first is named Amy with AID, `EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM`, the Issuer of the second is named Bob with AID, `EFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBrAqjsK`, the Issuer of the third is named Cat with AID, `EDIPMvklXKhmkPreYpZfzBrAqjsKFk66jpf3uFv7An2E`, and the Issuer of the fourth is named Dug with AID, `EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr`. Notice that the AID of each Issuer appears in the Issuer, `i` field of its respective ACDC below.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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
  "v":  "ACDCCAAJSONAACD.",
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
  "v":  "ACDCCAAJSONAACD.",
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
  "v":  "ACDCCAAJSONAACD.",
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "u":  "0AHcgNghkDaG7OY1wjaDAE0q",
  "i":  "EAqjsKFk66jpf3uFv7An2EDIPMvklXKhmkPreYpZfzBr",
  "rd": "EMwsxUelUauaXtMxTfPAMPAI6FkekwlOjkggtymRy7x",
  "s":  "EAXRZOkogZ2A46jrVPTzlSkUPqGGeIZ8a8FWS7a6s4re",
  "a":  "EFrn9y2PYgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lk",
  "r":  "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR"
}
```



##### Two Edges

Suppose that the Edge Section of the ACDC issued by Amy, when expanded, has two Edges labeled `poe` for proof-of-entitlement and `data`.  The `poe` Edge links back to the ACDC issued by Bob's AID and the `data` Edge links back to the ACDC issued by Cat's AID. 

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

Edge section subschema:

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

Notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the Node, `n` field value of the `bob` Edge block is the value of the SAID, `d` field of the ACDC issued by Bob, and the Node, `n` field value of the `cat` Edge block is the value of the SAID, `d` field of the ACDC issued by Cat. Further, notice that the top-level Edge-group of the ACDC issued by Amy has no Operator field. This means that the default m-ary operator `AND` is applied. Therefore Amy's ACDC is invalid unless both the linked ACDCs issued by Bob and Cat are valid. Moreover, notice that the Edge block labeled `poe` in Amy's ACDC has no operator, `o` field. This means that the default unary Operator `I2I` is applied. This means that Bob's ACDC must designate Amy's AID as the Issuee in order for this edge to be valid. Finally, notice that the Edge block labeled `data` in Amy's ACDC has an Operator, `o` field value of `NI2I`. This means that there is no requirement that Cat's ACDC designates Amy's AID as the Issuee in order for this Edge to be valid. If it does, fine; if not, also fine.

Suppose that the expanded Attribute section of the ACDC issued by Bob is as follows:

```json
"a":
{
  "d": "EgveY4-9XgOcLxUderzwLIr9Bf7V_NHwY1lkFrn9y2PY",
  "u": "0ADAE0qHcgNghkDaG7OY1wja",
  "i": "EmkPreYpZfFk66jpf3uFv7vklXKhzBrAqjsKAn2EDIPM",
}
```

Because the value of the Issuee, `i`, field in Bob's Attribute section is Amy's AID, the default `I2I` Operator on Amy's Edge labeled `poe` is satisfied. Thus, Amy's ACDC validates with respect to its Edges.

Both Edges can be individually compacted and private because they include both `d` and `u` fields. The Schema allows this compact Edge form with a `oneOf` composition on each of the Edges. Notice that in the compact Edge form the value of each labeled Edge field is the SAID, `d` field value of its expanded form.  To elaborate, the Edge section can be expressed in one of three forms. These are:
- compact private form, as a whole, because its schema uses the `oneOf` composition.
- partially expanded form with compact private Edges because each Edge's subschema uses the `oneOf` composition.
- fully expanded form with fully expanded Edge blocks because of the combination of `oneOf` compositions at both the section and Edge levels.

##### Nested edge group
 
In contrast to the previous example, this example shows a nested Edge-group in the ACDC issued by Amy. Amy's Edge Section when expanded, has three Edges labeled `poe`, `sewer`, and `gas` as shown below, where each of these labeled Edges links back to the ACDCs issued respectively by Bob's, Cat's, and Dug's AIDs. The nested Edge-group has label `poa` for proof-of-address. Some of the field values in the compact version of the ACDC issued by Amy must change because the Edge section and Schema are both different.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

Edge section subschema:

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

Notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the Node, `n` field value of the `poe` Edge block is the value of the SAID, `d` field of the ACDC issued by Bob, the Node, `n` field value of the `sewer` Edge block is the value of the SAID, `d` field of the ACDC issued by Cat, and the Node, `n` field value of the `gas` Edge block is the value of the SAID, `d` field of the ACDC issued by Dug. Further, notice that the top-level Edge-group of the ACDC issued by Amy has no Operator field. This means that the default m-ary Operator `AND` is applied. This top-level Edge-group includes one Edge labeled `poe` and a nested Edge-group labeled `poa`. This nested Edge group has two Edges labeled `sewer` and `gas`. The Edge-group's Operator, `o` field value is `OR`. This means that the Edge-group is valid if either of its Edges is valid. The unary Operators on the `poe`, `sewer`, and `gas` edges are the default `I2I` because the Operator, `o` field is missing in each of the associated Edge blocks. This means that each of the ACDCs issued by Bob, Cat, and Dug must designate Amy's AID as the Issuee in order for the associated Edge to be valid. But as long as the `poe` Edge is valid, only one of the Edges, `sewer` or `gas`, must be valid for Amy's ACDC to be valid with respect to its Edges.

To clarify, with this version of the Edge Section, Amy's ACDC is valid with respect to its Edges if the ACDC issued by Bob is valid, and either Cat's or Dug's ACDCs are valid.  Amy's Edge section with nested Edge-group provides a sub-graph with an `AND-OR` logic tree on its three Edges. This is suitable for many types of business logic, such as KYC, for example, where the combination of a proof of entitlement (`poe`) and a proof of one of two types of addresses (`sewer` or `gas`) is required.

The three Edges and the nested Edge-group could each be individually compacted and private because they include both `d` and `u` fields. To simplify the example, however, the `oneOF` composition was not applied to the individual Edges and nested Edge group. Therefore, the simplified Schema only allows the expanded form of the individual Edges and nested Edge group.  Nonetheless, the Edge section, as a whole can be expressed in compact private form because its Schema uses the `oneOf` composition. 

##### Compact public edge section example

Suppose instead Amy is not concerned about privacy at either the section or the individual Edge and Edge group level. Amy therefore could benefit from using an expanded Edge Section that is more compact. Furthermore,  Amy's ACDC may not benefit from specifying a different Schema constraint on the far nodes of its Edges. Therefore, compared to the example above, several fields could be eliminated. These include all the `u` fields, all but the top-level Edge Section `d` field, and all the `s` fields.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

Edge section subschema:

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

Notice how much more compact is the Edge section in partially expanded form. As before, notice that the SAID, `d` field value in the Edge Section (top-level Edge-group) block is the same as the value of the Edge Section, `e` field in the ACDC issued by Amy. Also, notice that the value of the `poe` field is the value of the SAID, `d` field of the ACDC issued by Bob. This is the simple compact form of an Edge described above. Likewise, for the `sewer` field value and the `gas` field value which are respectively the value of the SAID, `d` field of the ACDCs issued by Cat and Dug. All the Edges and nested Edge-groups are public because they include a `u` field. The schema uses the `oneOf` composition operator on all three Edges. This indicates that the compact form is simple compact form because their expanded block form only includes a Node, `n` field and not a SAID, `d` field.

Otherwise, this example's semantics are the same as the previous example, just more compact.

##### Examples Summary

As the examples above have shown, the Edge Section syntax enables the composable and extensible but efficient expression of aggregating (m-ary) and unary Operators both singly and in combination as applied to nestable groups of Edges.  The intelligent defaults for the Operator, `o`, field, namely, `AND` for m-ary Operators and `I2I` for unary Operators, means that in many use cases, the Operator, `o`, field, does not even need to be present. This syntax is sufficiently general in scope to satisfy the contemplated use cases, including those with more advanced business logic. 

### Rule Section  

The Rule Section, `r` field appears as a top-level block within the ACDC and denotes the start of subsequent Rule-groups. The purpose of the Rules section is to provide a set of rules or conditions as a Ricardian Contract [[43]]. The important features of a Ricardian contract are that it is both human and machine-readable and referenceable by a cryptographic digest. A JSON-encoded document or block, such as the Rules section block, is a practical example of both a human and machine-readable document.  The Rules section's top-level SAID, `d` field provides the digest.  This provision supports the bow-tie model of RC. 

The Rules Section includes labeled nested blocks called Rules that provide the legal language (terms , conditions, definitions etc). The labeled clauses can be structured hierarchically, where each Rule, in turn, can include nested labeled Rules. The labels on the Rules may follow a structured naming or numbering convention. These provisions enable the Rules section to satisfy the features of an RC. 

#### Block types

There are two types of field maps or blocks that may appear as values of fields within the Rule Section, `r` field either at the top level of the Rule block itself or nested. These are Rules or Rule-groups. Rules may only appear as locally unique labeled (using non-reserved labels)  blocks nested within an Rule-Group. There are two exceptional forms for Rules, compact and simple compact form. In these two forms, the labeled Rule field value is not a block but a string. These exceptions are defined below.

Nested Rule-groups may only appear as locally unique labeled blocks nested within another Rule-group. The block type, Rule or Rule-group, is indicated by its corresponding labeled subschema, with the exception of the top-level Rule-group, which is the Rules Section and is indicated by the Rules Section subschema. A Rule-group is indicated by the presence of one or more non-reserved labeled fields whose value represents a nested Rule or Rule-Groups.  

#### Rule discovery 

In compact form, the discovery of either the Rules section as a whole or a given Rule or Rule-group begins with the provided SAID. Because the SAID, `d`, field of any block is a cryptographic digest with high collision resistance, it provides a universally unique identifier to the referenced block details (whole rule section or individual rule). The discovery of a service endpoint URL that provides database access to a copy of the Rules section or to any of its Rules or Rule-groups may be bootstrapped via an OOBI that links the service endpoint URL to the SAID of the respective block [@OOBI_ID]. Alternatively, the Issuer may provide as an attachment at issuance a copy of the referenced contract associated with the whole rule section or any Rule. In either case, after a successful issuance exchange, the Issuee of any ACDC will have either a copy or a means of obtaining a copy of any referenced contracts in whole or in part of all ACDCs so issued. That Issuee will then have everything subsequently needed to make a successful presentation or disclosure to a Disclosee. This is the essence of Percolated Discovery.

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

The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Rule-group block following the SAID, `d`, field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [@Hash]. An adversary, when given both the block's subschema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [@RB][@DRB].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's subschema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Labeled nested rule and rule-group fields

Rules and Rule-group nested within a Rule-group appear as labeled fields whose labels are not any of the reserved field labels for a Rule-group, namely, `[d, u, l]`. Labeled nested Rule or Rule-group fields must appear after all of any fields with a reserved field label. 

To elaborate, each nested Rule or Rule-group block shall be labeled with a locally unique non-reserved field label that indicates the type of the nested block. To clarify, each nested block gets its own field with its own local (to the ACDC Rule Section) label. The field's value may be either the Rule or Rule-group block or, in compact form, a string. The compact forms are defined below.

Note that each nested block shall not include a type field. The type of each block is provided by that associated nested subschema with a matching label. This is in accordance with the design principle of ACDCs that may be succinctly expressed as "type-is-schema." This approach varies somewhat from other types of property graphs, which often do not have a Schema [[56]][[57]][[58]]. Because ACDCs have a Schema, they leverage it to provide property graph types with a cleaner separation of concerns.   

A main distinguishing feature of a property graph (PG) is that both nodes and Edges may have a set of properties [[56]][[57]][[58]].  Each Rule-group's block provides its additional properties vis-a-vis a property graph as labeled fields. Additional properties may be inferred from the properties of an enclosing Rule-group block. Each labeled Rule type is defined by the subschema designated by its label. 


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

##### Compact Rule

Given that an individual Rule block includes a SAID, `d` field, a compact representation of the Rule's block is provided by replacing it with its SAID. This is called a compact Rule. The Schema for that clause's label shall indicate that the clause field value is the clause block SAID by using a `oneOf` composition of the compact form and the expanded form. This may be useful for compacting lengthy clauses and then expanding them later. When the clause block also includes a UUID, `u` field, then compacting also hides the clause's legal language for later disclosure. A compact clause without a UUID, `u` field is a public compact clause.  A compact clause with a UUID, `u` field is a private compact clause. 

##### UUID, `u` field

The UUID, `u` field is optional, but when it appears, it shall appear as the second field in the Rule Section block following the SAID, `d` field. The value of this field shall be a cryptographic strength salty-nonce with approximately 128 bits of entropy. When present, the UUID, `u` field means that the block's SAID, `d` field value provides a secure cryptographic digest of the contents of the block [[48]]. An adversary, when given both the block's subschema and its SAID, cannot discover the remaining contents of the block in a computationally feasible manner, such as a rainbow table attack [[30]] [[31]].  Therefore, the block's UUID, `u` field securely blinds the contents of the block via its SAID, `d` field notwithstanding knowledge of both the block's subschema and SAID.  Moreover, a cryptographic commitment to that block's SAID, `d` field does not provide a fixed point of correlation to the block's field values themselves unless and until there has been a disclosure of those field values.

##### Legal, `l` field

The legal language, `l`, field in each clause block provides the associated legal language as a string.


##### Simple compact Rule

When a Rule block has only one field, that is, its legal, `l` field, i.e., it has no other properties, then the rule block may use an alternate simplified, compact form where the labeled rule field value is the value of its legal, `l` field. The rule is, therefore, public.  This enables the very compact expression of simple public Rules. The Schema for that Rule's label shall indicate that the Rule's compact value is the value of its Legal, `l` field in expanded form and use a `oneOF` composition whose expanded block has only a Legal, `l` field.

#### Rule section examples

##### Private rules

Some Rules and Rule-groups, as opposed to the Rule Section as a whole, may benefit from confidential disclosure. Recall that individual Rule and Rule-group blocks may have their own SAID, `d`, field and UUID, `u,` field. To clarify, a Rule or Rule-group block with both a SAID, `d`, and UUID, `u` fields, where that UUID has sufficiently high entropy, protects the compact form of that block from discovery via a rainbow table attack merely from its SAID and subschema [[30]] [[31]]. Therefore, such a Rule or Rule-group may kept hidden until later disclosure. These are called private Rules or Rule-groups. The following example has an independently hidable Rule-group and Rules.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

Notice that the value of the Rules Section's UUID, `d` field matches the value of the Rule, `r` field in the ACDC issued by Amy. Furthermore, notice that in the compact private Rule form the value of the labeled Rules is the value of the SAID, `d` field from the expanded form.

#### Simple compact public Rules

When there is no benefit to a private Rules section, then its UUID fields are not needed. Moreover, for the Rules themselves do not benefit from a dedicated SAID, `d` field. Given this change, the Rules section can be expressed in a compact form with simple compact Rules. Recall that in simple, compact form, each Rule block shall not have any fields besides the Legal, `l` field. This field value then becomes the value of the labeled Rule block.

Issued by Amy:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

Rules section expanded:

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

Rules section simple compact private Rules:

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

