## ACDC variants
<!-- file name: acdc-variants.md -->
There are several variants of ACDCs determined by the presence/absence of certain fields and/or the value of those fields when used in combination. The primary ACDC variants are public, private, metadata, and bespoke. A given variant may be Targeted (Untargeted). 

All the variants have two alternate forms, compact and non-compact. In the compact form of any variant, the values of the top-level fields for the Schema, Attribute, Attribute aggregate, Edge, and Rule sections are the SAIDs (digests) of the corresponding expanded (non-compact) form of each section {{SAID}}. Additional variants arise from the presence or absence of different fields inside the Attribute or Attribute aggregate section. 

At the top level, the presence (absence), of the UUID, `u`, field produces two additional variant combinations. These are private (public), respectively. In addition, a present but empty UUID, `u`, field produces a private metadata variant. Furthermore, a given variant may be either Targeted or Untargeted based on the presence of the Issuee field in the Attribute or Attribute aggregate sections. Similarly, any variant with an Attribute section may have nested sub-blocks within the Attribute section that are either compact or non-compact. This enables nested Partial Disclosure. The type of disclosure a given variant supports may be dependent on how the different sections appear in the ACDC.

An overview of each variant is explained below.

### Most compact form SAID

As defined in the Schema section below, ACDC variants are defined by composable JSON Schema. The primary Operator for such composition is `oneOf`. The use of the `oneOf` operator for an ACDC schema enables the use of any combination of compacted/uncompacted top-level sections as well as nested blocks. When compact, any section or nested block may be represented merely by its [[10]] [[39]].

However, for the sake of verifiability, each section or block that is compactable shall have only one SAID regardless of how many different variants its `oneOf` compositions allow. Therefore, there must be one and only one unambiguous way to compute the SAID of a compactifiable section or block with compactifiable nested blocks. This is called the "most compact form" SAID computation algorithm. The basis of the algorithm is that the SAID of a given block is verifiable against that block in expanded form but that SAID can be embedded in an enclosing block in compact form. The SAID of the enclosing block makes a verifiable commitment to the given block via the appearance of only the SAID of the given block. The SAID of the "most compact form" can be computed by a depth-first search.  First, compute the SAIDs of the expanded leaf nodes of the tree, then compact the leaves, then compute the SAIDs of their enclosing blocks, then compact those, and so on until the trunk has been reached.

To verify the SAID, just reverse the process. First, expand a given block, verify its SAID, expand its enclosed blocks, verify their SAIDs, and so on as deep as needed or until the leaves are reached. The main advantage of "most compact form" SAID computation is that it enables verification of portions of a set of nested compactifiable subblocks against their SAIDs without requiring that the whole tree of subblocks be exposed. This is essential to Graduated Disclosure.

The algorithm for computing the “most compact form" of a block for computing its SAID is as follows.

- A SAIDed block is any block that has a SAID field `d` when in block-level expanded form. Any SAIDed block is compactifiable into the compact form consisting of a string field whose value is the SAID of the block-level expanded form and whose label is the block label. This compact form shall appear as the first variant in the `oneOf` subschema list for its labeled field. In block-level expanded form, all fields with non-SAIDed subblock values are fully expanded, whereas all fields with SAIDed subblocks are represented in compact form. The latter requires first representing each SAIDed subblock in block-level expanded form, computing its SAID, and then using that SAID to represent it in compact form.

- A SAIDed block that does not have any nested SAIDed subblocks as fields is a leaf block. Its SAID shall be computed on the full expanded representation of the block. It may then be represented in the compact form but using the SAID computed on its fully expanded form. To clarify, because the leaf has no SAIDed subblocks, its block-level expanded form is fully expanded, including any fields with subblocks. This is a concern when it has subblocks whose schema has `oneOf` composition variants that omit any details. This is the case for a simple-compact edge or a simple-compact rule (see below under the Edge and Rule sections), which are each a nested (non-SAIDed) subblock with a non-SAID-based compact `oneOf` variant. These are special cases, and the most detailed variant of the subblock shall be the fully expanded form. 

- The computation of the SAID of any SAIDed block is as follows. 
    - Fully expand any field within the block whose value is a Non-SAIDed sub-block.
    - Compact any field within the block whose value is a leaf block with its SAID computed on its fully expanded form.
    - Compact any non-leaf SAIDed block with its SAID computed on its block-level expanded form. The SAID of any non-leaf SAIDed subblock is recursively computed. Once all SAIDed subblocks have been represented in compact form, the SAID of the SAIDed block is then computed on the resultant representation.
    
    
To elaborate, the algorithm recursively compacts a nested set of SAIDed subblocks by doing a depth-first search of all SAIDed subblock fields in a given block where each branch of the search terminates when it reaches a leaf subblock whereupon it computes the SAID of the leaf, compacts it and then continues the depth-first search until all the SAIDed subblock fields are compacted and then computes the SAID of that block and then ascends the tree, compacting subblocks and computing block SAIDs until it reaches the top-level block that is the ACDC itself. 

Thereby, there is one and only one "most compact form" SAID for any given ACDC as well as one and only one "most compact form" SAID for each of the ACDC top-level sections regardless of all the different variants allowed by the `oneOf` compositions of any SAIDed subblocks. This "most compact form," SAID, is what is used to reference an ACDC as the node value of an Edge or to reference a section.


### Compact ACDC

The top-level section field values of a Compact ACDC are the SAIDs of each uncompacted top-level section. The section field labels are `s`, `a`, (`A`), `e`, and `r`.


### Public ACDC

Given that there is no top-level UUID, `u`, field in an ACDC, then knowledge of both the schema of the ACDC and the top-level SAID, `d`, field may enable the discovery of the remaining contents of the ACDC via a rainbow table attack [[30]] [[31]]. Therefore, although the top-level, `d`, field is a cryptographic digest, it may not securely blind the contents of the ACDC when knowledge of the Schema is available.  The field values may be discoverable. Consequently, any cryptographic commitment to the top-level SAID, `d`, field may provide a fixed point of correlation potentially to the ACDC field values themselves in spite of non-disclosure of those field values. Thus, an ACDC without a top-level UUID, `u`, field must be considered a public (non-confidential) ACDC.

### Private ACDC

Given a top-level UUID, `u`, field, whose value has sufficient cryptographic entropy, then the top-level SAID, `d`, field of an ACDC may provide a secure cryptographic digest that blinds the contents of the ACDC [[48]]. An adversary when given both the Schema of the ACDC and the top-level SAID, `d`, field, is not able to discover the remaining contents of the ACDC in a computationally feasible manner such as through a rainbow table attack [[30]] [[31]]. Therefore, the top-level, UUID, `u`, field may be used to securely blind the contents of the ACDC notwithstanding knowledge of the Schema and top-level, SAID, `d`, field.  Moreover, a cryptographic commitment to that that top-level SAID, `d`, field does not provide a fixed point of correlation to the other ACDC field values themselves unless and until there has been a disclosure of those field values. Thus, an ACDC with a sufficiently high entropy top-level UUID, `u`, field may be considered a private (confidential) ACDC. enables a verifiable commitment to the top-level SAID of a private ACDC to be made prior to the disclosure of the details of the ACDC itself without leaking those contents. This is called Partial Disclosure. Furthermore, the inclusion of a UUID, `u`, field in a block also enables Selective Disclosure mechanisms described later in the section on [Selective Disclosure](#selective-disclosure).

### Metadata ACDC 

An empty, top-level UUID, `u`, field appearing in an ACDC indicates that the ACDC is a metadata ACDC. The purpose of a metadata ACDC is to provide a mechanism for a Discloser to make cryptographic commitments to the metadata of a yet to be disclosed private ACDC without providing any point of correlation to the actual top-level SAID, `d`, field of that yet to be disclosed ACDC. The top-level SAID, `d`, field, of the metadata ACDC, is cryptographically derived from an ACDC with an empty top-level UUID, `u`, field so its value will necessarily be different from that of an ACDC with a high entropy top-level UUID, `u`, field value. Nonetheless, the Discloser may make a non-repudiable cryptographic commitment to the metadata SAID in order to initiate a contractually protected exchange without leaking correlation to the actual ACDC to be disclosed [[44]. A Disclosee may verify the other metadata information in the metadata ACDC before agreeing to any restrictions imposed by the future disclosure. The metadata includes the Issuer, the Schema, the provenanced Edges, and the Rules (terms-of-use). The top-level Attribute section, `a`, field value, or the top-level Attribute aggregate, `A` field value of a metadata ACDC may be empty so that its value is not correlatable across disclosures (presentations). Should the potential Disclosee refuse to agree to the Rules, then the Discloser has not leaked the SAID of the actual ACDC or the SAID of the Attribute block that would have been disclosed.

Given the metadata ACDC, the potential Disclosee is able to verify the Issuer, the Schema, the provenanced Edges, and Rules prior to agreeing to the Rules.  Similarly, an Issuer may use a metadata ACDC to get agreement to a contractual waiver expressed in the Rules section with a potential Issuee prior to issuance. Should the Issuee refuse to accept the terms of the waiver, then the Issuer has not leaked the SAID of the actual ACDC that would have been issued nor the SAID of its attributes block nor the Attribute values themselves.

When a metadata ACDC is disclosed (presented), only the Discloser's signature(s) is attached, not the Issuer's signature(s). This precludes the Issuer's signature(s) from being used as a point of correlation until after the Disclosee has agreed to the terms in the rule section. When Contractually Protected Disclosure is used, the Issuer's signature(s) is not disclosed to the Disclosee until after the Disclosee has agreed to the terms. The Disclosee is protected from a forged Discloser because, ultimately, verification of the disclosed ACDC will fail if the Discloser does not eventually provide verifiable Issuer's signatures. Nonetheless, should the potential Disclosee not agree to the terms of the disclosure expressed in the Rules section, then the Issuer's signature(s) is not leaked.

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