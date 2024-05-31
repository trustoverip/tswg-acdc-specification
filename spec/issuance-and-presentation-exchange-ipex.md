## Issuance and Presentation Exchange (IPEX)
<!-- file name: issuance-and-presentation-exchange-ipex.md  -->

The Issuance and Presentation Exchange (IPEX) Protocol provides a uniform mechanism for the issuance and presentation of ACDCs [[ref: ACDC]] in a securely attributable manner. A single protocol is able to work for both types of exchanges by recognizing
that all exchanges (both issuance and presentation) may be modeled as the disclosure of information by a Discloser to a Disclosee. 

The difference between exchange types is the information disclosed, not the mechanism for disclosure. Furthermore, the chaining mechanism of ACDCs and support for both Targeted and Untargeted ACDCs provide sufficient variability to accommodate the differences in applications or use cases without requiring a difference in the exchange protocol itself. This greatly simplifies the exchange protocol. This simplification has two primary advantages. The first is enhanced security. A well-delimited protocol can be designed and analyzed to minimize and mitigate attack mechanisms.

The second is convenience. A standard, simple protocol is easier to implement, support, update, understand, and adopt. The tooling is more consistent.

This IPEX [[ref: IPEX]] protocol leverages important features of ACDCs and ancillary protocols such as CESR [[1]], SAIDs [[3]], and CESR-Path proofs [[ref: Proof-ID]] as well as Ricardian Contracts [[43]] and Graduated Disclosure (Metadata, Partial, Selective, Full) to enable Contractually Protected Disclosure. Contractually Protected Disclosure includes both Chain-Link Confidential [[44]] and Contingent Disclosure [[ref: ACDC]].

### Exchange Protocol

| Discloser | Disclosee | Initiate | Contents | Description |
|:-:|:-:|:-:|:--|:--|
| | `apply`| Y | Schema or its SAID, Attribute field label list, signature on `apply` or its SAID | Schema SAID is type of ACDC, optional label list for Selective Disclosure, CESR-Proof signature|
|`spurn`|  | N | |rejects `apply` |
|`offer`|  | Y | metadata ACDC or its SAID, signature on `offer` or its SAID  | includes Schema or its SAID, other Partial Disclosures, Selective Disclosure label list, CESR-Proof signature |
| | `spurn` | N | |rejects `offer` |
| | `agree`| N | signature on `offer` or its SAID | CESR-Proof signature |
|`spurn`|  | N | |rejects `agree` |
|`grant`|  | Y | Full or Selective Disclosure ACDC, signature on `grant` or its SAID  | includes Attribute values, CESR-Proof signature |
| | `admit` | N | signature on `grant` or its SAID  | CESR-Proof signature |

#### Commitments via SAID

All the variants of an ACDC have various degrees of expansion of the compact variant. Therefore, an Issuer commitment via a signature (direct) or KEL anchored seal (indirect) to any variant of ACDC (metadata, compact, partial, nested partial, full, selective, etc.)  makes a cryptographic commitment to the top-level section fields shared by all variants of that ACDC because the value of a top-level section field is either the SAD or the SAID of the SAD of the associated section. Both a SAD and its SAID, when signed or sealed, each provide a verifiable commitment to the SAD. In the former, the signature or seal verification is directly against the SAD itself. In the latter, the SAID as digest must first be verified against its SAD, and then the signature or seal on the SAID may be verified. This indirect verifiability (one or multiple levels of commitment via cryptographic digests) assumes that the cryptographic strength of the SAID digest is equivalent to the cryptographic strength of the signature used to sign it. To clarify, because all variants share the same top-level structure as the compact variant, then a signature on any variant may be used to verify the Issuer's commitment to any other variant either directly or indirectly, in whole or in part on a top-level section by top-level section basis. This cross-variant Issuer commitment verifiability is an essential property that supports Graduated Disclosure by the Disclosee of any or all variants, whether Full, Compact, Metadata, Partial, Selective etc.

To elaborate, the SAID of a given variant is useful even when it is not the SAID of the variant the Issuer signed because, during Graduated Disclosure, the Discloser may choose to sign or seal that given variant to fulfill a given step in an IPEX Graduated Disclosure transaction. The Discloser thereby can make a verifiable disclosure in a given step of the SAD of a given variant that fulfills a commitment made in a prior step via its signature or seal on merely the SAID of the SAD of the variant so disclosed.

For example, the metadata variant of an ACDC will have a different SAID than the compact variant because some of the top-level field values may be empty in the metadata variant. One can think of the metadata variant as a partial manifest that only includes those top-level sections that the Discloser is committing to disclose in order to induce the Disclosee to agree to the contractual terms of use when disclosed. 

To elaborate, an IPEX transaction is between the Discloser and Disclosee, who both may make non-repudiable commitments to each other via signing or sealing variants of the ACDC to be disclosed. Typically, this means that the Discloser will eventually need to fulfill its commitment with proof of disclosure to the Disclosee. This proof may be satisfied either against the Discloser's signature or seal on the actual disclosed SAD or against the Discloser's signature or seal on the SAID of the actual disclosed SAD. In addition, the Disclosee will typically require proof of issuance via a non-repudiable signature or seal by the Issuer on a variant of the disclosed SAD that is verifiable (directly or indirectly) against the variant that is the disclosed SAD.

To summarize, when the Issuer commits to the composed Schema of an ACDC it is committing to all the variants so composed. As described above, the top-level field values in the compact variant enable verification against disclosure of any of the other Issuer committed variants because they all share the same top-level structure. This applies even to the metadata variant in spite of it only providing values for some top-level sections and not others. The verifiablity of a top-level section is separable.

Consequently, the IPEX protocol must specify how a validator does validation of any variant in a Graduated Disclosure. To restate, there are two proofs that a Discloser must provide. The first is proof of issuance (PoI), and the second is proof of disclosure (PoD). In the former, the Discloser provides the variant via its SAD that was actually signed or seal (as SAD or SAID of SAD) by the Issuer in order for the Disclosee to verify authentic issuance via the signature on that variant.  In the latter, the Discloser must disclose the Issuer-enabled (via Schema composition) variant that the Discloser offered to disclose as part of the Graduated Disclosure process.


#### IPEX Validation

The goal is to define a validation process (set of rules) that works for all variants of an ACDC and for all types of Graduated Disclosure of that ACDC.

For example, in the bulk issuance of an ACDC (see bulk issued ACDCs in the [Annex](#bulk-issued-private-acdcs)), the Issuer only signs or seals the blinded SAID of the SAD, which is the compact variant of the ACDC, not the SAD itself. This enables a Discloser to make a proof of inclusion of the ACDC in a bulk issuance set by unblinding the signature on the blinded SAID without leaking correlation to anything but the blinded SAID itself. To clarify, the Disclosee can verify the commitment to the SAID via set inclusion without disclosing any other information about the ACDC. Issuer signing or sealing of the SAID, not the SAD, also has the side benefit of minimizing the computation of large numbers of bulk-issued commitments.

##### Issuer Commitment Rules

The Issuer must provide a signature or seal on the SAID of the most compact form variant defined by the Schema of the ACDC (see the "most compact form" algorithm above). 

The different variants of an ACDC form a hash tree (using SAIDs).
A commitment to the top-level SAID of the compact version of the ACDC is equivalent to a commitment to the hash tree root (trunk). This makes a verifiable commitment to all expansions of that tree.
Different variants of an ACDC (SADs with SAIDs) correspond to different paths through the hash tree.
The process of verifying a nested block SAD against its SAID is essentially verifying proof of inclusion of the branch of the hash tree that includes that nested block. This allows a single commitment (signature or seal) to provide PoI of the presentation of any Schema-authorized variants of the ACDC.

An Issuer may provide signatures or seals on the SAIDs of other variants, as well as signatures or seals on the SADs of other variants.

To summarize:

Proof of Issuance (PoI) is provided by disclosing the SAID of the most compact variant and the verifiable commitment (signature or seal) by the Issuer on that SAID.

Proof of Disclosure (PoD) is provided by disclosing the SAD of the most compact variant and then recursively disclosing (expanding) the nested SADs of each of the blocks of the most compact variant as needed for the promised disclosure.

Thus, for any disclosed variant of an ACDC, the Disclosee need only verify one PoI as defined above and may need to verify a specific PoD for a given disclosed variant as defined above.

### Disclosure-specific (bespoke) issued ACDCs

Chaining two or more ACDCs via edges enables disclosure-specific issuance of bespoke issued ACDCs. A given Discloser of an ACDC issued by some Issuer may want to augment the disclosure with additional contractual obligations or additional information sourced by the Discloser where those augmentations are specific to a given context, such as a specific Disclosee. A given Discloser issues its own bespoke ACDC referencing some other ACDC via an Edge. This means that the normal validation logic and tooling for a chained ACDC can be applied without complicating the presentation exchange logic. Furthermore, Attributes in other ACDCs pointed to by Edges in the bespoke ACDC may be addressed by Attributes in the bespoke ACDC using JSON Pointer or CESR-SAD-Path proof references that are relative to the node SAID in the Edge [[6]] [[ref: Proof_ID]].

For example, this approach enables the bespoke ACDC to identify (name) the Disclosee directly as the Issuee of the bespoke ACDC. This enables contractual legal language in the Rules section of the bespoke ACDC that references the Issuee of that ACDC as a named party. Signing the agreement to the offer of that bespoke ACDC consummates a contract between the named Issuer and the named Issuee. This approach means that custom or bespoke presentations do not need additional complexity or extensions. Extensibility comes from reusing the tooling for issuing ACDCs to issue a bespoke or disclosure-specific ACDC. When the only purpose of the bespoke ACDC is to augment the contractual obligations associated with the disclosure, then the Attribute section, `a`, field value of the bespoke ACD may be empty, or it may include properties whose only purpose is to support the bespoke contractual language.

Similarly, this approach effectively enables a type of rich presentation or combined disclosure where multiple ACDCs may be referenced by edges in the bespoke ACDC that each contributes some Attribute(s) to the effective set of Attributes referenced in the bespoke ACDC. The bespoke ACDC enables the equivalent of a rich presentation without requiring any new tooling [[59]].

#### Example of a bespoke issued ACDC

Consider the following disclosure-specific ACDC. The Issuer is the Discloser, the Issuee is the Disclosee. The Rules section includes a context-specific anti-assimilation clause that limits the use of the information to a single one-time usage purpose, in this case, admittance to a restaurant.  The ACDC includes an edge that references some other ACDC that may, for example, be a coupon or gift card. The Attribute section includes the date and place of admittance.

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
