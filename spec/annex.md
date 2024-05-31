## Annex
<!-- file name: annex.md -->
### Performance and Scalability

The Compact Disclosure and distribute property graph fragment mechanisms in ACDC can be leveraged to enable high performance at scale. Simply using SAIDs and signed SAIDs of ACDCs in whole or in part enables compact but securely attributed and verifiable references to ACDCs to be employed anywhere performance is an issue. Only the SAID and its signature need be transmitted to verify secure attribution of the data represented by the SAID. Later receipt of the data may be verified against the SAID. The signature does not need to be re-verified because a signature on a SAID is making a unique (to within the cryptographic strength of the SAID) commitment to the data represented by the SAID. The actual detailed ACDC in whole or in part may then be cached or provided on-demand or just-in-time.

Hierarchical decomposition of data into a distributed verifiable property graph, where each ACDC is a distributed graph fragment, enables performant reuse of data or more compactly performant reuse of SAIDs and their signatures. The metadata and attribute sections of each ACDC provide a node in the graph and the Edge section of each ACDC provides the Edges to that node. Higher-up nodes in the graph with many lower-level nodes need only be transmitted, verified, and cached once per every node or leaf in the branch not redundantly re-transmitted and re-verified for each node or leaf as is the case for document-based Verifiable Credentials where the whole equivalent of the branched (graph) structure must be contained in one document. This truly enables the bow-tie model popularized by Ricardian Contracts, not merely for contracts, but for all data authenticated, authorized, referenced, or conveyed by ACDCs.

[//]: # (Cryptographic Strength and Security {#sec:annexB .informative})

### Cryptographic Strength and Security

#### Cryptographic Strength

For crypto-systems with Perfect Security, the critical design parameter is the number of bits of entropy needed to resist any practical brute force attack. In other words, when a large random or pseudo-random number from a cryptographic strength pseudo-random number generator (CSPRNG) [@CSPRNG] expressed as a string of characters is used as a seed or private key to a cryptosystem with Perfect Security, the critical design parameter is determined by the amount of random entropy in that string needed to withstand a brute force attack. Any subsequent cryptographic operations must preserve that minimum level of cryptographic strength. In information theory, [@IThry][@ITPS] the entropy of a Message or string of characters is measured in bits. Another way of saying this is that the degree of randomness of a string of characters can be measured by the number of bits of entropy in that string.  Assuming conventional non-quantum computers, the conventional wisdom is that, for systems with Information- Theoretic or Perfect Security, the seed/key needs to have on the order of 128 bits (16 bytes, 32 hex characters) of entropy to practically withstand any brute force attack. A cryptographic quality random or pseudo-random number expressed as a string of characters will have essentially as many bits of entropy as the number of bits in the number. For other crypto systems such as digital signatures that do not have Perfect Security, the size of the seed/key may need to be much larger than 128 bits in order to maintain 128 bits of cryptographic strength.

An N-bit long base-2 random number has 2<sup>N</sup> different possible values. Given that no other information is available to an attacker with Perfect Security, the attacker may need to try every possible value before finding the correct one. Thus, the number of attempts that the attacker would have to try maybe as much as 2<sup>N-1</sup>.  Given available computing power, one can show easily that 128 is a large enough N to make brute force attack computationally infeasible.

Suppose that the adversary has access to supercomputers. Current supercomputers can perform on the order of one quadrillion operations per second. Individual CPU cores can only perform about 4 billion operations per second, but a supercomputer will parallelly employ many cores. A quadrillion is approximately 2<sup>50</sup> = 1,125,899,906,842,624. Suppose somehow an adversary had control over one million (2<sup>20</sup> = 1,048,576) supercomputers which could be employed in parallel when mounting a brute force attack. The adversary could then try 2<sup>50</sup> * 2<sup>20</sup> = 2<sup>70</sup> values per second (assuming very conservatively that each try only took one operation).

There are about 3600 * 24 * 365 = 313,536,000 = 2<sup>log<sub>2</sub>313536000</sup>=2<sup>24.91</sup> ~= 2<sup>25</sup> seconds in a year. Thus, this set of a million super computers could try 2<sup>50+20+25</sup> = 2<sup>95</sup> values per year. For a 128-bit random number this means that the adversary would need on the order of 2<sup>128-95</sup> = 2<sup>33</sup> = 8,589,934,592 years to find the right value. This assumes that the value of breaking the cryptosystem is worth the expense of that much computing power. Consequently, a cryptosystem with perfect-security and 128 bits of cryptographic strength is computationally infeasible to break via brute force attack.

#### Information Theoretic Security and Perfect Security

The highest level of cryptographic security with respect to a cryptographic secret (seed, salt, or private key) is called Information Theoretic Security [[ref: ITPS]][[19]]. A cryptosystem that has this level of security cannot be broken algorithmically even if the adversary has nearly unlimited computing power including quantum computing. The system must be broken by brute force if at all. Brute force means that in order to guarantee success, the adversary must search for every combination of key or seed. A special case of Information Theoretic Security is called Perfect Security [[ref: ITPS]].  Perfect Security means that the ciphertext provides no information about the key. There are two well-known cryptosystems that exhibit Perfect Security. The first is a One-time-pad ([[20]]) or Vernum Cipher [[21]], and the other is Secret splitting [[21]], a type of secret sharing [[21]] that uses the same technique as an OTP.


[//]: # (# Examples {#sec:annexC .informative} )

### Selective Disclosure

::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/21
:::

As explained previously in section 5, the primary difference between Partial Disclosure and Selective Disclosure is determined by the correlatability with respect to its encompassing block after Full Disclosure of the detailed field value. A partially disclosable field becomes correlatable to its encompassing block after its Full Disclosure. Whereas a selectively disclosable field may be excluded from the Full Disclosure of any other selectively disclosable fields in its encompassing block. After Selective Disclosure, the selectively disclosed fields are not correlatable to the so far undisclosed but selectively disclosable fields in the same encompassing block. In this sense, Full Disclosure means detailed disclosure of the selectively disclosed attributes not detailed disclosure of all selectively disclosable attributes.

Recall that Partial Disclosure is an essential mechanism needed to support Chain-link Confidentiality [@CLC]. The Chain-link Confidentiality exchange offer requires Partial Disclosure, and Full Disclosure only happens after acceptance of the offer. Selective Disclosure, on the other hand, is an essential mechanism needed to unbundle in a correlation minimizing way a single commitment by an Issuer to a bundle of fields (i.e., a nested block or array of fields). This allows separating a "stew" of "ingredients" (Attributes) into its constituent ingredients (attributes) without correlating the constituents via the stew.

ACDCs, inherently benefit from a minimally sufficient approach to Selective Disclosure that is simple enough to be universally implementable and adoptable. This does not preclude support for other more sophisticated but optional approaches. But the minimally sufficient approach should be universal so that at least one Selective Disclosure mechanism be made available in all ACDC implementations. To clarify, not all instances of an ACDC must employ the minimal Selective Sisclosure mechanisms as described herein but all ACDC implementations must support any instance of an ACDC that employs the minimal Selective Disclosure mechanisms as described above.

#### Tiered selective disclosure mechanisms

The ACDC chaining mechanism reduces the need for Selective Disclosure in some applications. Many non-ACDC verifiable credentials provide bundled credentials because there is no other way to associate the attributes in the bundle of credentials. These bundled credentials could be refactored into a graph of ACDCs. Each of which is separately disclosable and verifiable thereby obviating the need for Selective Disclosure.

Nonetheless, some applications require bundled Attributes and therefore may benefit from the independent Selective Disclosure of bundled Attributes. This is provided by selectively disclosable attribute ACDCs.

The use of a revocation Registry is an example of a type of bundling, not of Attributes in a credential, but uses of a credential in different contexts. Unbundling the usage contexts may be beneficial. This is provided by bulk-issued ACDCs.

Finally, in the case where the correlation of activity of an Issuee across contexts even when the ACDC used in those contexts is not correlatable may be addressed of a variant of bulk-issued ACDCs that have unique Issuee AIDs with an independent TEL Registry per Issuee instance. This provides non-repudiable (recourse supporting) disclosure while protecting from the malicious correlation between 2nd parties and other 2nd and/or 3rd parties as to who (Issuee) is involved in a presentation.

#### Basic selective disclosure mechanism

The basic Selective Disclosure mechanism shared by all is comprised of a single aggregated blinded commitment to a list of blinded commitments to undisclosed values. Membership of any blinded commitment to a value in the list of aggregated blinded commitments may be proven without leaking (disclosing) the unblinded value belonging to any other blinded commitment in the list. This enables provable Selective Disclosure of the unblinded values. When a non-repudiable digital signature is created on the aggregated blinded commitment then any disclosure of a given value belonging to a given blinded commitment in the list is also non-repudiable. This approach does not require any more complex cryptography than digests and digital signatures. This satisfies the design ethos of minimally sufficient means. The primary drawback of this approach is verbosity. It trades ease and simplicity and adoptability of implementation for size. Its verbosity may be mitigated by replacing the list of blinded commitments with a Merkle tree of those commitments where the Merkle tree root becomes the aggregated blinded commitment.

Given sufficient cryptographic entropy of the blinding factors, collision resistance of the digests, and unforgeability of the digital signatures, either inclusion proof format (list or Merkle tree digest) prevents a potential Disclosee or adversary from discovering in a computationally feasible way the values of any undisclosed blinded value details from the combination of the schema of those value details and either the aggregated blinded commitment and/or the list of aggregated blinded commitments [@Hash][@HCR][@QCHC][@Mrkl][@TwoPI][@MTSec]. A potential Disclosee or adversary would also need both the blinding factor and the actual value details.

Selective Disclosure in combination with Partial Disclosure for Chain-link Confidentiality provides comprehensive correlation minimization because a Discloser may use a non-disclosing metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain-link Confidentiality expressed in the Rules section [@CLC]. Thus, only malicious Disclosees who violate Chain-link Confidentiality may correlate between independent disclosures of the value details of distinct members in the list of aggregated blinded commitments. Nonetheless, they are not able to discover any as-of-yet undisclosed (unblinded) value details.

#### Selectively disclosable attribute ACDC

In a selectively disclosable attribute ACDC, the set of Attributes is provided as an array of blinded blocks. Each Attribute in the set has its own dedicated blinded block. Each block has its own SAID, `d`, field and UUID, `u`, field in addition to its attribute field or fields. When an Attribute block has more than one Attribute field, then the set of fields in that block are not independently selectively disclosable but must be disclosed together as a set. Notable is that the field labels of the selectively disclosable Attributes are also blinded because they only appear within the blinded block. This prevents unpermissioned correlation via contextualized variants of a field label that appear in a selectively disclosable block. For example, localized or internationalized variants where each variant's field label(s) each use a different language or some other context correlatable information in the field labels themselves.

A selectively disclosable Attribute section appears at the top level using the field label `A`. This is distinct from the field label `a` for a non-selectively disclosable Attribute section. This makes clear (unambiguous) the semantics of the Attribute section's associated Schema. This also clearly reflects the fact that the value of a compact variant of selectively disclosable Attribute section is an aggregate, not a SAID. As described previously, the top-level selectively disclosable Attribute aggregate section, `A`, field value is an aggregate of cryptographic commitments used to make a commitment to a set (bundle) of selectively disclosable attributes. The derivation of its value depends on the type of Selective Disclosure mechanism employed. For example, the aggregate value could be the cryptographic digest of the concatenation of an ordered set of cryptographic digests, a Merkle tree root digest of an ordered set of cryptographic digests, or a cryptographic accumulator.

The Issuee Attribute block is absent from an uncompacted Untargeted selectively disclosable ACDC as follows:

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

The Issuee Attribute block is present in an uncompacted Targeted selectively disclosable ACDC as follows:

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

Given that each Attribute block's UUID, `u`, field has sufficient cryptographic entropy, then each Attribute block's SAID, `d`, field provides a secure cryptographic digest of its contents that effectively blinds the Attribute value from discovery given only its Schema and SAID. To clarify, the adversary despite being given both the Schema of the Attribute block and its SAID, `d`, field, is not able to discover the remaining contents of the Attribute block in a computationally feasible manner such as a rainbow table attack [@RB][@DRB].  Therefore, the UUID, `u`, field of each Attribute block enables the associated SAID, `d`, field to securely blind the block's contents notwithstanding knowledge of the block's Schema and that SAID, `d`, field.  Moreover, a cryptographic commitment to that SAID, `d`, field does not provide a fixed point of correlation to the associated Attribute (SAD) field values themselves unless and until there has been specific disclosure of those field values themselves.

Given a total of ‘N’ elements in the Attributes array, let a<sub>i</sub> represent the SAID, `d`, field of the attribute at zero-based index ‘i'. More precisely, the set of Attributes is expressed as the ordered set,

\{a<sub>i</sub> for all i in \{0, ..., N-1\}\}.

The ordered set of a<sub>i</sub> may be also expressed as a list, that is,

\[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].

#### Composed Schema for selectively disclosable attribute section

Because the selectively disclosable Attributes are provided by an array (list), the uncompacted variant in the Schema uses an array of items and the `anyOf` composition Operator to allow one or more of the items to be disclosed without requiring all to be disclosed. Thus, both the `oneOf` and `anyOf` composition Operators are used. The `oneOf` is used to provide compact Partial Disclosure of the aggregate, ‘A’, as the value of the top-level selectively disclosable Attribute section, `A`, field in its compact variant and the nested `anyOf` Operator is used to enable Selective disclosure in the uncompacted selectively disclosable variant.

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

To be explicit, using the targeted example above, let a<sub>0</sub> denote the SAID of the Issuee Attribute, a<sub>1</sub> denote the SAID of the score Attribute, and a<sub>2</sub> denote the SAID of the name Attribute then the aggregated digest ‘A’ is computed as follows:

A = H(C(a<sub>0</sub>, a<sub>1</sub>, a<sub>2</sub>)).

Equivalently using ‘+’ as the infix concatenation operator, the aggregated digest is ‘A’ is computed as follows:

A = H(a<sub>0</sub> + a<sub>1</sub> + a<sub>2</sub>).

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [[ref: BDC][[ref: BDay][[ref: QCHC][[ref: HCR][[48]].

In compact form, the value of the selectively disclosable top-level Attribute section, `A`, field is set to the aggregated value ‘A’. This aggregate ‘A’ makes a blinded cryptographic commitment to the all the ordered elements in the list,

\[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].

Moreover, because each a<sub>i</sub> element also makes a blinded commitment to its block's (SAD) attribute value(s), disclosure of any given a<sub>i</sub> element does not expose or disclose any discoverable information detail about either its own or another block's Attribute value(s). Therefore, one may safely disclose the full list of a<sub>i</sub> elements without exposing the blinded block Attribute values.

Proof of inclusion in the list consists of checking the list for a matching value. A computationally efficient way to do this is to create a hash table or B-tree of the list and then check for inclusion via lookup in the hash table or B-tree.

To protect against later forgery given a later compromise of the signing keys of the Issuer, the Issuer must anchor an issuance proof digest seal to the ACDC in its KEL. This seal binds the signing Key State to the issuance. There are two cases. In the first case, an issuance/revocation Registry is used. In the second case, an issuance/revocation Registry is not used.

When the ACDC is registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the issuance (Inception) event in the ACDC's TEL entry. The issuance event in the TEL includes the SAID of the ACDC. This binds the ACDC to the issuance proof seal in the Issuer's KEL through the TEL entry.

When the ACDC is not registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the ACDC itself.

In either case, this issuance proof seal makes a verifiable binding between the issuance of the ACDC and the Key State of the Issuer at the time of issuance. Because aggregated value ‘A’ provided as the Attribute section, `A`, field, value is bound to the SAID of the ACDC which is also bound to the Key State via the issuance proof seal, the Attribute details of each attribute block are also bound to the Key state.

The requirement of an anchored issuance proof seal means that the forger must first successfully publish in the KEL of the Issuer an inclusion proof digest seal bound to a forged ACDC. This makes any forgery attempt detectable. To elaborate, the only way to successfully publish such a seal is in a subsequent Interaction Event in a KEL that has not yet changed its Key State via a Rotation Event. Whereas any KEL that has changed its Key State via a Rotation must be forked before the Rotation. This makes the forgery attempt either both detectable and recoverable via Rotation in any KEL that has not yet changed its Key State or detectable as Duplicity in any KEL that has changed its Key State. In any event, the issuance proof seal ensures detectability of any later attempt at forgery using compromised keys.

Given that aggregate value ‘A’ appears as the compact value of the top-level Attribute section, `A`, field, the Selective Disclosure of the Attribute at index ‘j’ may be proven to the Disclosee with four items of information. These are:

- The actual detailed disclosed Attribute block itself (at index ‘j’) with all its fields.
- The list of all Attribute block digests, \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\] that includes a<sub>j</sub>.
- The ACDC in compact form with selectively disclosable Attribute section, `A`, field value set to aggregate ‘A’.
- The signature(s), ‘s’, of the Issuee on the ACDC's top-level SAID, `d`, field.

The actual detailed disclosed Attribute block is only disclosed after the Disclosee has agreed to the terms of the Rules section. Therefore, in the event the potential Disclosee declines to accept the terms of disclosure, then a presentation of the compact version of the ACDC and/or the list of Attribute digests, \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\]. does not provide any point of correlation to any of the Attribute values themselves. The Attributes of block ‘j’ are hidden by a<sub>j</sub>\ and the list of Attribute digests \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\] is hidden by the aggregate ‘A’. The Partial Disclosure needed to enable Chain-link Confidentiality does not leak any of the selectively disclosable details.

The Disclosee may then verify the disclosure by:
- computing a<sub>j</sub> on the selectively disclosed Attribute block details.
- confirming that the computed a<sub>j</sub> appears in the provided list \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].
- computing ‘A’ from the provided list \[a<sub>0</sub>, a<sub>1</sub>, ...., a<sub>N-1</sub>\].
- confirming that the computed ‘A’ matches the value, ‘A’, of the selectively disclosable Attribute section, `A`, field value in the provided ACDC.
- computing the top-level SAID, `d`, field of the provided ACDC.
- confirming the presence of the issuance seal digest in the Issuer's KEL
- confirming that the issuance seal digest in the Issuer's KEL is bound to the ACDC top-level SAID, `d`, field either directly or indirectly through a TEL Registry entry.
verifying the provided signature(s) of the Issuee on the provided top-level SAID, `d` field value.

The last 3 steps that culminate with verifying the signature(s) require determining the Key state of the Issuer at the time of issuance.  Therefore, this may require additional verification steps as per the KERI and SAD Path protocols.

A private selectively disclosable ACDC provides significant correlation minimization because a Discloser may use a metadata ACDC prior to acceptance by the Disclosee of the terms of the Chain Link Confidentiality expressed in the Rule section [[44]. Thus, only malicious Disclosees who violate Chain Lnk Confidentiality may correlate between presentations of a given private selectively disclosable ACDC. Nonetheless, the malicious Disclosees are not able to discover any undisclosed Attributes.

#### Inclusion proof via Merkle tree root digest

The inclusion proof via aggregated list may be somewhat verbose when there are a large number of attribute blocks in the selectively disclosable Attribute section. A more efficient approach is to create a Merkle tree of the attribute block digests and let the aggregate, ‘A’, be the Merkle tree root digest [[49]]. Specifically, set the value of the top-level selectively disclosable attribute section, `A`, field to the aggregate, ‘A’ whose value is the Merkle tree root digest [[49]].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [[50]] [[51]]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, a<sub>j</sub> contributed to the Merkle tree root digest, ‘A. For ACDCs with a small number of attributes, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Hierarchical derivation at issuance of selectively disclosable attribute ACDCs

The amount of data transferred between the Issuer and Issuee (or recipient in the case of an Untargeted ACDC) at issuance of a selectively disclosable attribute ACDC may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUDI, `u`, fields from a shared secret salt [[29]].

There are several ways that the Issuer may securely share that secret salt. Given that an Ed25519 key pair(s) controls each of the Issuer and Issuee AIDs, (or recipient AID in the case of an Untargeted ACDC), a corresponding X15519 asymmetric encryption Key pair(s) may be derived from each controlling Ed25519 key pair(s) [[36]] [[37]] [[38]] [[60]]. An X25519 public key may be derived securely from an Ed25519 public key [[46]] [[60]]. Likewise, an X25519 private key may be derived securely from an Ed25519 private key [[46]] [[60]].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [[46]] [[45]]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used as high entropy cryptographic material from which the secret salt may be derived.

In a non-interactive approach, the Issuer derives an X25519 asymmetric public encryption key from the Issuee's (recipient's) public Ed25519 public key. The Issuer then encrypts the secret salt with that public asymmetric encryption key and signs the encryption with the Issuer's private Ed25519 signing key. This is transmitted to the Issuee, who verifies the signature and decrypts the secret salt using the private X25519 decryption key derived from the Issuee's private Ed25519 key. This non-interactive approach is more scalable for AIDs that are controlled with a multi-sig group of signing keys. The Issuer can broadcast to all members of the Issuee's (or recipient's) multi-sig signing group individually asymmetrically encrypted and signed copies of the secret salt may be derived. Likewise, both compact and uncompacted versions of the ACDC then may be generated. The derivation path for the top-level UUID, `u`, field (for private ACDCs), is the string "0" and derivation path the zeroth indexed attribute in the Attributes array is the string ‘0/0’. Likewise, the next Attribute's derivation path is the string ‘0/1’ and so forth.

In addition to the shared salt and ACDC template, the Issuer also provides its signature(s) on its own generated Compact version ACDC. The Issuer also may provide references to the anchoring issuance proof seals. Everything else an Issuee (or recipient) needs to make a verifiable presentation/disclosure can be computed at the time of presentation/disclosure by the Issuee.

### Bulk-issued private ACDCs

The purpose of bulk issuance is to enable the Issuee to use ACDCs with unique SAIDs more efficiently to isolate and minimize correlation across different usage contexts. Each member of a set of bulk-issued ACDCs is essentially the same ACDC but with a unique SAID. This enables public commitments to each of the unique ACDC SAIDs without correlating between them. A private ACDC may be effectively issued in bulk as a set. In its basic form, the only difference between each ACDC is the top-level SAID, ‘d’, and UUID, ‘u’ field values. To elaborate, bulk issuance enables the use of uncorrelatable copies while minimizing the associated data transfer and storage requirements involved in the issuance. Essentially each copy (member) of a bulk-issued ACDC set shares a template that both the Issuer and Issuee use to generate on-the-fly a given ACDC in that set without requiring that the Issuer and Issuee exchange and store a unique copy of each member of the set independently. This minimizes the data transfer and storage requirements for both the Issuer and the Issuee. The Issuer is only required to provide a single signature for the bulk issued aggregate value ‘B’ defined below. The same signature may be used to provide proof of issuance of any member of the bulk-issued set. The signature on ‘B’ and ‘B’ itself are points of correlation but these need only be disclosed after Contractually Protected Disclosure is in place, i.e., no permissioned correlation. Thus, correlation requires a colluding Second-party who engages in unpermissioned correlation.

An ACDC provenance chain is connected via references to the SAIDs given by the top-level SAID, `d`, fields of the ACDCs in that chain.  A given ACDC thereby makes commitments to other ACDCs. Expressed another way, an ACDC may be a node in a directed graph of ACDCs. Each directed Edge in that graph emanating from one ACDC includes a reference to the SAID of some other connected ACDC. These edges provide points of correlation to an ACDC via their SAID reference. Private bulk-issued ACDCs enable the Issuee to better control the correlatability of presentations using different presentation strategies.

For example, the Issuee could use one copy of a bulk-issued private ACDC per presentation even to the same Verifier. This strategy would consume the most copies. It is essentially a one-time-use ACDC strategy. Alternatively, the Issuee could use the same copy for all presentations to the same Verifier and thereby only permit the Verifier to correlate between presentations it received directly but not between other Verifiers. This limits the consumption to one copy per Verifier. In yet another alternative, the Issuee could use one copy for all presentations in a given context with a group of Verifiers, thereby only permitting correlation among that group.

This is about Permissioned Correlation. Any Verifier that has received a complete presentation of a private ACDC has access to all the fields disclosed by the presentation but the terms of the Chain-link Confidentiality agreement may forbid sharing those field values outside a given context. Thus, an Issuee may use a combination of bulk-issued ACDCs with Chain-link Confidentiality to control Permissioned Correlation of the contents of an ACDC while allowing the SAID of the ACDC to be more public. The SAID of a private ACDC does not expose the ACDC contents to an unpermissioned 3rd party. Unique SAIDs belonging to bulk issued ACDCs prevent 3rd parties from making a provable correlation between ACDCs via their SAIDs in spite of those SAIDs being public. This does not stop malicious Verifiers (as 2nd parties) from colluding and correlating against the disclosed fields, but it does limit provable correlation to the information disclosed to a given group of malicious colluding Verifiers. To restate, unique SAIDs per copy of a set of private bulk issued ACDC prevent unpermissioned 3rd parties from making provable correlations, in spite of those SAIDs being public, unless they collude with malicious Verifiers (2nd parties).

In some applications, Chain Link Confidentiality is insufficient to deter unpermissioned correlation. Some Verifiers may be malicious with sufficient malicious incentives to overcome whatever counter incentives the terms of the contractual Chain-link confidentiality may impose. In these cases, more aggressive technological anti-correlation mechanisms such as bulk issued ACDCs may be useful. To elaborate, in spite of the fact that Chain-link confidentiality terms of use may forbid such malicious correlation, making such correlation more difficult technically may provide better protection than Chain-link confidentiality alone [[44]].

It is important to note that any group of colluding malicious Verifiers always may make a statistical correlation between presentations despite technical barriers to cryptographically provable correlation. This is called contextual linkability. In general, there is no cryptographic mechanism that precludes statistical correlation among a set of colluding Verifiers because they may make cryptographically unverifiable or unprovable assertions about information presented to them that may be proven as likely true using merely statistical correlation techniques. Linkability, due the context of the disclosure itself, may defeat any unlinkability guarantees of a cryptographic technique. Thus, without contractually protected disclosure, contextual linkability in spite of cryptographic unlinkability may make the complexity of using advanced cryptographic mechanisms to provide unlinkability an exercise in diminishing returns.

#### Basic bulk issuance proceedure

The amount of data transferred between the Issuer and Issuee (or recipient of an untargeted ACDC) at issuance of a set of bulk issued ACDCs may be minimized by using a hierarchical deterministic derivation function to derive the value of the UUID, `u`, fields from a shared secret salt [[29]].

As described above, there are several ways that the Issuer may share a secret salt securely. Given that the Issuer and Issuee (or recipient for Untargeted ACDCs) AIDs are each controlled by an Ed25519 key pair(s), a corresponding X15519 asymmetric encryption key pair(s) may be derived from the controlling Ed25519 key pair(s) [[36]][[37]][[38]]. An X25519 public key may be securely derived from an Ed25519 public key [[46]][[60]]. Likewise, an X25519 private key may be securely derived from an Ed25519 private key [[46]][[60]].

In an interactive approach, the Issuer derives a public asymmetric X25519 encryption key from the Issuee's published Ed25519 public key and the Issuee derives a public asymmetric X25519 encryption key from the Issuer's published Ed25519 public key. The two then interact via a Diffie-Hellman (DH) key exchange to create a shared symmetric encryption key [[46]][[45]]. The shared symmetric encryption key may be used to encrypt the secret salt or the shared symmetric encryption key itself may be used has high entropy cryptographic material from which the secret salt may be derived.

In a non-interactive approach, the Issuer derives an X25519 asymmetric public encryption key from the Issuee's (or recipient's) public Ed25519 public key. The Issuer then encrypts the secret salt with that public asymmetric encryption key and signs the encryption with the Issuer's private Ed25519 signing key. This is transmitted to the Issuee, who verifies the signature and decrypts the secret salt using the private X25519 decryption key derived from the Issuee's private Ed25519 key. This non-interactive approach is more scalable for AIDs that are controlled with a multi-sig group of signing keys. The Issuer can broadcast to all members of the Issuee's (or recipient's) multi-sig signing group individually asymmetrically encrypted and signed copies of the secret salt.

In addition to the secret salt, the Issuer also provides a template of the private ACDC but with empty UUID, `u`, and SAID, `d`, fields at the top-level of each nested block with such fields. Each UUID, `u`, field value is then derived from the shared salt with a deterministic path prefix that indexes both its membership in the bulk-issued set and its location in the ACDC. Given the UUID, `u`, field value, the associated SAID, `d`, field value may then be derived. Likewise, both full and compact versions of the ACDC may then be generated. This generation is analogous to that described in the section for Selective disclosure ACDCs but extended to a set of private ACDCs.

The initial element in each deterministic derivation path is the string value of the bulk-issued member's copy index ‘k’, such as ‘0’, ‘1’, ‘2’, etc.  Specifically, if ‘k denotes the index of an ordered set of bulk-issued private ACDCs of size ‘M, the derivation path starts with the string ‘k’, where ‘k is replaced with the decimal or hexadecimal textual representation of the numeric index ‘k’. Furthermore, a bulk-issued private ACDC with a private Attribute section uses ‘k’ to derive its top-level UUID and ‘k/0’ to derive its Attribute section UUID. This hierarchical path is extended to any nested private Attribute blocks. This approach is further extended to enable bulk-issued Selective Disclosure ACDCs by using a similar hierarchical derivation path for the UUID field value in each of the selectively disclosable blocks in the array of Attributes. For example, the path ‘k/j’ is used to generate the UUID of Attribute index ‘j at bulk-issued ACDC index k’.

In addition to the shared salt and ACDC template, the Issuer also provides a list of signatures of SAIDs, one for each SAID of each copy of the associated compact bulk-issued ACDC.  The Issuee (or recipient) can generate on-demand each compact or uncompacted ACDC from the template, the salt, and its index ‘k’. The Issuee does not need to store a copy of each bulk-issued ACDC, merely the template, the salt, and the list of signatures.

The Issuer MUST anchor in its KEL an issuance proof digest seal of the set of bulk-issued ACDCs. The issuance proof digest seal makes a cryptographic commitment to the set of top-level SAIDs belonging to the bulk-issued ACDCs. This protects against later forgery of ACDCs in the event the Issuer's signing keys become compromised.  A later attempt at forgery requires a new event or new version of an event that includes a new anchoring issuance proof digest seal that makes a cryptographic commitment to the set of newly forged ACDC SAIDs. This new anchoring event of the forgery is therefore detectable.

Similarly, to the process of generating a Selective disclosure attribute ACDC, the issuance proof digest is an aggregate that is aggregated from all members in the bulk-issued set of ACDCs. The complication of this approach is that it must be done in such a way as to not enable provable correlation by a third party of the actual SAIDs of the bulk-issued set of ACDCs. Therefore, the actual SAIDs must not be aggregated but blinded commitments to those SAIDs instead. With blinded commitments, knowledge of any or all members of such a set does not disclose the membership of any SAID unless and until it is unblinded. Recall that the purpose of bulk issuance is to allow the SAID of an ACDC in a bulk issued set to be used publicly without correlating it in an unpermissioned provable way to the SAIDs of the other members.

The basic approach is to compute the aggregate denoted, ‘B’, as the digest of the concatenation of a set of blinded digests of bulk issued ACDC SAIDs. Each ACDC SAID is first blinded via concatenation to a UUID (salty nonce) and then the digest of that concatenation is concatenated with the other blinded SAID digests. Finally, a digest of that concatenation provides the aggregate.

Suppose there are ‘M’ ACDCs in a bulk issued set. Using zero-based indexing for each member of the bulk-issued set of ACDCs, such that index ‘k’ satisfies ‘k’ in \{0, ..., M-1\}, let <sub>k</sub> denote the top-level SAID of an ACDC in an ordered set of bulk-issued ACDCs. Let v<sub>k</sub> denote the UUID (salty nonce) or blinding factor that is used to blind that said. The blinding factor, v<sub>k</sub>, is not the top-level UUID, `u`, field of the ACDC itself but an entirely different UUID used to blind the ACDC's SAID for the purpose of aggregation. The derivation path for v<sub>k</sub> from the shared secret salt is ‘k’, where ‘k’ is the index of the bulk-issued ACDC.

Let c<sub>k</sub> = v<sub>k</sub> + d<sub>k</sub> denote the blinding concatenation where ‘+’ is the infix concatenation Operator.
Then the blinded digest, b<sub>k</sub>, is given by,
b<sub>k</sub> = H(c<sub>k</sub>) = H(v<sub>k</sub> + d<sub>k</sub>),
where H is the digest Operator. Blinding is performed by a digest of the concatenation of the binding factor, v<sub>k</sub>, with the SAID, d<sub>k</sub> instead of XORing the two. An XOR of two elements whose bit count is much greater than 2 is not vulnerable to a birthday table attack [[32]] [[31]] [[33]]. In order to XOR, however, the two must be of the same length. Different SAIDs MAY be of different lengths, however, and therefore, may require different length blinding factors. Because concatenation is length independent it is simpler to implement.

The aggregation of blinded digests, ‘B’, is given by,
B = H(C(b<sub>k</sub> for all k in \{0, ..., M-1\})),
where ‘C’ is the concatenation Operator and ‘H’ is the digest Operator. This aggregate, ‘B’, provides the issuance proof digest.

The aggregate, ‘B’, makes a blinded cryptographic commitment to the ordered elements in the li’t \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] A commitment to ‘B’ is a commitment to all the b<sub>k</sub> and hence all the d<sub>k</sub>.

Given sufficient collision resistance of the digest Operator, the digest of an ordered concatenation is not subject to a birthday attack on its concatenated elements [[33]][[32]][[35]][[34]][[48]].

Disclosure of any given b<sub>k</sub> element does not expose or disclose any discoverable information detail about either the SAID of its associated ACDC or any other ACDC's SAID. Therefore, the full list of b<sub>k</sub> elements can be disclosed safely without exposing the blinded bulk issued SAID values, d<sub>k</sub>.

Proof of inclusion in the list of blinded digests consists of checking the list for a matching value. A computationally efficient way to do this is to create a hash table or B-tree of the list and then check for inclusion via lookup in the hash table or B-tree.

A proof of inclusion of an ACDC in a bulk-issued set requires disclosure of v<sub>k</sub> which is only disclosed after the Disclosee has accepted (agreed to) the terms of the rule section. Therefore, in the event the Disclosee declines to accept the terms of disclosure, then a presentation/disclosure of the compact version of the ACDC does not provide any point of correlation to any other SAID of any other ACDC from the bulk set that contributes to the aggregate ‘B’. In addition, because the other SAIDs are hidden by each b<sub>k</sub> inside the aggregate, ‘B’, even a presentation/disclosure of, \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] does not provide any point of correlation to the actual bulk-issued ACDC without disclosure of its v<sub></sub>. Indeed, if the Discloser uses a metadata version of the ACDC in its offer, then even its SAID is not disclosed until after acceptance of terms in the Rules section.

To protect against later forgery given a later compromise of the signing keys of the Issuer, the Issuer must anchor an issuance proof seal to the ACDC in its KEL. This seal binds the signing Key State to the issuance. There are two cases. In the first case, an issuance/revocation Registry is used. In the second case, an issuance/revocation Registry is not used.

When the ACDC is registered using an issuance/revocation TEL, then the issuance proof seal digest is the SAID of the issuance (Inception) event in the ACDC's TEL entry. The issuance event in the TEL uses the aggregate value, ‘B’, as its identifier value. This binds the aggregate, ‘B’, to the issuance proof seal in the Issuer's KEL through the TEL.

Recall that the usual purpose of a TEL is to provide a VDR  that enables dynamic revocation of an ACDC via a state of the TEL. A Verifier checks the state at the time of use to check if the associated ACDC has been revoked. The Issuer controls the state of the TEL. The Registry identifier, `rd`, field is used to identify the public Registry which usually provides a unique TEL entry for each ACDC. Typically, the identifier of each TEL entry is the SAID of the TEL's Inception Event which is a digest of the event's contents which include the SAID of the ACDC. In the bulk issuance case, however, the TEL's Inception Event contents include the aggregate, ‘B’, instead of the SAID of a given ACDC. Recall that the goal is to generate an aggregate value that enables an Issuee to selectively disclose one ACDC in a bulk-issued set without leaking the other members of the set to unpermissioned parties (2nd or 3rd).

Using the aggregate, ‘B’ of blinded ACDC SAIDs as the TEL Registry entry identifier allows all members of the bulk-issued set to share the same TEL without any 3rd party being able to discover which TEL any ACDC is using in an unpermissioned provable way. Moreover, a 2nd party may not discover in an unpermissioned way any other ACDCs from the bulk-issued set not specifically disclosed to that 2nd party. In order to prove to which TEL a specific bulk issued ACDC belongs, the full inclusion proof must be disclosed.

When the ACDC is not registered using an issuance/revocation TEL then the issuance proof seal digest is the aggregate, ‘B’, itself.

In either case, this issuance proof seal makes a verifiable binding between the issuance of all the ACDCs in the bulk issued set and the Key State of the Issuer at the time of issuance.

A Discloser may make a basic provable non-repudiable Selective Disclosure of a given bulk issued ACDC, at index ‘k’ by providing to the Disclosee four items of information (proof of inclusion). These are as follows:

- The ACDC in compact form (at index ‘k’) where ‘d<sub>k</sub> as the value of its top-level SAID, `d`, field.
- The blinding factor, v<sub>k</sub> from which b<sub>k</sub> = H(v<sub>k</sub> + d<sub>k</sub>) may be computed.
- The list of all blinded SAIDs, \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\] that includes b<sub>k</sub>.
- A reference to the anchoring seal in the Issuer's KEL or TEL that references the aggregate ‘B’. The event that references the seal or the TEL event that references ‘B’ must be signed by the issuer so the signature on either event itself is sufficient to prove authorized issuance.

The aggregate ‘B’ is a point of unpermissioned correlation but not permissioned correlation. To remove ‘B’ as a point of unpermissioned correlation requires using independent TEL bulk-issued ACDCs described in the section so named below.

A Disclosee may then verify the disclosure by:

- computing d<sub>j</sub> on the disclosed compact ACDC.
- computing b<sub>k</sub> = H(v<sub>k</sub> + d<sub>k</sub>).
- confirming that the compute b<sub>k</sub> appears in the provided list \[b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\].
- computing the aggregate ‘B’ from the provided list [b<sub>0</sub>, b<sub>1</sub>, ...., b<sub>M-1</sub>\]..
- confirming the presence of an issuance seal digest in the Issuer's KEL that makes a commitment to the aggregate, ‘B’, either directly or indirectly through a TEL Registry entry. This provides proof of authorized issuance.

The last 3 steps that culminate with verifying the anchoring seal also require verifying the Key state of the Issuer at the time of issuance, this may require additional verification steps as per the KERI, PTEL, and CESR-Proof protocols.

The requirement of an anchored issuance proof seal of the aggregate ‘B’ means that the forger must first successfully publish in the KEL of the Issuer an inclusion proof digest seal bound to a set of forged bulk-issued ACDCs. This makes any forgery attempt detectable. To elaborate, the only way to successfully publish such a seal is in a subsequent Interaction Event in a KEL that has not yet changed its Key State via a Rotation Event. Whereas any KEL that has changed its Key State via a Rotation must be forked before the Rotation. This makes the forgery attempt either both detectable and recoverable via Rotation in any KEL that has not yet changed its Key State or detectable as Duplicity in any KEL that has changed its Key state. In any event, the issuance proof seal makes any later attempt at forgery using compromised keys detectable.

#### Inclusion proof via Merkle tree 

The inclusion proof via aggregated list may be somewhat verbose when there are a very large number of bulk-issued ACDCs in a given set. A more efficient approach is to create a Merkle tree of the blinded SAID digests, b<sub>k</sub> and set the aggregate ‘B’ value as the Merkle tree root digest [[49]].

The Merkle tree needs to have appropriate second-pre-image attack protection of interior branch nodes [[50]] [[51]]. The Discloser then only needs to provide a subset of digests from the Merkle tree to prove that a given digest, b<sub>k</sub> contributed to the Merkle tree root digest. For a small-numbered bulk-issued set of ACDCs, the added complexity of the Merkle tree approach may not be worth the savings in verbosity.

#### Bulk issuance of private ACDCs with unique issuee AIDs 

One potential point of provable but unpermissioned correlation among any group of colluding malicious Disclosees (2nd party Verifiers) may arise when the same Issuee AID is used for presentation/disclosure to all Disclosees in that group. Recall that the contents of private ACDCs are not disclosed except to permissioned Disclosees (2nd parties). Thus, a common Issuee AID would be a point of correlation only for a group of colluding malicious verifiers. But in some cases, removing this unpermissioned point of correlation may be desirable.

One solution to this problem is for the Issuee to use a unique AID for the copy of a bulk-issued ACDC presented to each Disclosee in a given context. This requires that each ACDC copy in the bulk-issued set use a unique Issuee AID. This would enable the Issuee in a given context to minimize provable correlation by malicious Disclosees against any given Issuee AID. In this case, the bulk issuance process may be augmented to include the derivation of a unique Issuee AID in each copy of the bulk-issued ACDC by including in the Inception event that defines a given Issuee's SAID, a digest seal derived from the shared salt and copy index ‘k’. The derivation path for the digest seal is ‘k/0.’, where ‘k’ is the index of the ACDC. To clarify ‘k/0.’ specifies the path to generate the UUID to be included in the Inception Event that generates the Issuee AID for the ACDC at index ‘k’. This can be generated on-demand by the Issuee. Each unique Issuee AID also would need its own KEL. But generation and publication of the associated KEL can be delayed until the bulk-issued ACDC is actually used. This approach completely isolates a given Issuee AID to a given context with respect to the use of a bulk-issued private ACDC. This protects against even the unpermissioned correlation among a group of malicious Disclosees (2nd parties) via the Issuee AID.

### Independent Registry bulk-issued ACDCs

Recall that the purpose of using the aggregate ‘B’ for a bulk-issued set from which the Registry identifier is derived is to enable a set of bulk-issued ACDCs to share a single public Registry and/or a single anchoring seal in the Issuer's KEL without enabling unpermissioned correlation to any other members of the bulk set by virtue of the shared aggregate ‘B’ used for either the TEL or anchoring seal in the KEL. When using a TEL as Registry, this enables the issuance/revocation/transfer state of all copies of a set of bulk-issued ACDCs to be provided by a single Registry which minimizes the storage and compute requirements on the Registry while providing Selective Disclosure to prevent unpermissioned correlation via the public TEL Registry. When using an anchoring seal, this enables one signature to provide proof of inclusion in the bulk-issued aggregate ‘B’.

However, in some applications where Chain-link Confidentiality does not sufficiently deter malicious provable correlation by Disclosees (2nd party Verifiers), an Issuee may benefit from using ACDC with independent TELs or independent aggregates ‘B’ but that are still bulk-issued.

In this case, the bulk issuance process must be augmented so that each uniquely identified copy of the ACDC gets its own TEL entry (or equivalently its own aggregate ‘B’) in the registry. Each Disclosee (Verifier) of a full presentation/disclosure of a given copy of the ACDC only receives proof of one uniquely identified TEL and cannot provably correlate the TEL state of one presentation to any other presentation because the ACDC SAID, the TEL identifier, and the signature of the Issuer on each aggregate ‘B’ will be different for each copy. There is, therefore, no point of provable correlation, permissioned or otherwise. For example, this approach could be modulated by having a set of smaller bulk issued sets that are more contextualized than one large bulk-issued set.

The obvious drawbacks of this approach (independent unique TELs for each private ACDC) are that the size of the Registry database increases as a multiple of the number of copies of each bulk-issued ACDC and every time an Issuer must change the TEL state of a given set of copies it must change the state of multiple TELs in the Registry. This imposes both a storage and computation burden on the Registry. The primary advantage of this approach, however, is that each copy of a private ACDC has a uniquely identified TEL. This minimizes unpermissioned 3rd party exploitation via provable correlation of TEL identifiers even with colluding 2nd party Verifiers. They are limited to statistical correlation techniques.

In this case, the set of private ACDCs may or may not share the same Issuee AID because for all intents and purposes each copy appears to be a different ACDC even when issued to the same Issuee. Nonetheless, using unique Issuee AIDs may further reduce correlation by malicious Disclosees (2nd party verifiers) beyond using independent TELs.

To summarize the main benefit of this approach, in spite of its storage and compute burden, is that in some applications Chain-link Confidentiality does not sufficiently deter unpermissioned malicious collusion. Therefore, completely independent bulk-issued ACDCs may be used.

### Extensibility

The ACDC design leverages append-only verifiable data structures, named KELs and TELs, that have strong security properties that simplify end-verifiability and foster decentralization. Append-only verifiable data structures provide permission-less extensibility by Issuers, presenters, and/or Verifiers. By permission-less, it means that there is no shared governance over these data structures. This is completely decentralized and zero-trust. The fact that each ACDC has both a universally unique content-based identifier and a universally unique content-based Schema identifier that determines its type, enables permission-less ACDC type Registries. Because Attributes, claims, properties may be conveyed by verifiable graphs of ACDCs linked by their Edges whose Edges may also have properties, ACDCs may be modeled as labeled property graphs. Thus, enables extensibility of pre-existing already Issued ACDCs by appending additional attributes via application specific ACDCs or bespoke ACDCs. In other words, custom Attributes or properties are appended via chaining via one or more custom ACDCs defined by custom Schema (type-is-schema), not modifying in place pre-issued credential types.

In essence, an ACDC is really just a verifiable property graph fragment of an extensible distributed property graph where each node may be sourced by a different Issuer. This type of extensibility means there is no need for centralized permissioned name-space Registries to resolve name-space collisions of Attributes or properties. Each ACDC has a universally unique content address and a universally unique content addressable Schema (type-is-schema) as ACDC type that defines the namespace. The function of an extensible Registry of ACDC types now becomes merely Schema discovery or schema blessing for a given context or ecosystem. The reach of such a Registry of ACDC types can be tuned to the reach of desired interoperability by the ecosystem participants. Versioning is also simplified because Edges may still verify if the new Schema is backward compatible.

### ACDC protocol Message types

CESR support for the ACDC protocol includes conveying sections of an ACDC as CESR-compatible messages (packets). These messages can be part of a CESR stream or part of the attachment group to an ACDC. This is useful for sending the ACDC in its compact form and then attaching the section details as individual message packets. This enables one to cache sections so that they do not have to be transmitted repeatedly or reuse sections that are the same for multiple ACDC instances, which is often the case for the schema and rule sections. An ACDC message itself may have as an option a message type field. This allows CESR native versions of ACDCs. The default is that absent a message type field, an ACDC protocol message given by the version string field is an ACDC. All other message types shall have the message type field. The following table provides all the message types (ilks) for the ACDC protocol. The message type (ilk) field label is `t` and shall appear at the top-level immediately following the version string, `v` field.

#### Message type table

|Ilk|Name|Description|
|---|---|---|
|     |        | **Registry TEL Message Types** |
| rip | Registry Inception | Initialize blindable state ACDC Registry |
| upd | Update | Update transaction state of blindable state ACDC Registry |
|     |        | **ACDC Message** |
|     | ACDC | Default ACDC without Message type (ilk), `t` field |
| acd | ACDC | With Message type (ilk), `t` field |
|     |        | **ACDC Section Message types** |
| sch | Schema | Schema section Message |
| att | Attribute | Attribute section Message |
| agg | Aggregate | Attribute aggregate section Message |
| edg | Edge | Edge section Message |
| rul | Rule | Rules section Message |

#### ACDC Message with Message type field

The following table defines the top-level fields in an ACDC with a Message type field and their order of appearance. Some fields are optional, but all fields that appear shall appear in this order, `[v, t, d, u, i, s, a, A, e, r]`.

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: `ACDCMmmKKKKSSSS.`that provides protocol type, Version, serialization type, size, and terminator. |
|`t`| Message Type| Three-character Message type |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`u`| UUID | Random Universally Unique Identifier as fully qualified high entropy pseudo-random string, a salty nonce. |
|`i`| Issuer Identifier (AID)| AID whose control authority is established via KERI verifiable Key State. |
|`rd`| Registry Digest (SAID) | Issuance and/or revocation, transfer, or retraction Registry for ACDC |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of Attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of Attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of Edges or the block itself.|
|`r`| Rule | Either the SAID a block of Rules or the block itself. |

The Message type field enables fixed fields at the top level for an even more compact ACDC. The SAD of an ACDC is a labeled field map, such as an object in Javascript, or a dict in Python. The over-the-wire serialization could be CESR with fixed fields. Shown below is the labeled SAD as a Python dict (not the over-the-wire JSON or CESR).  The Message type, `t` field for ACDCs is an optional field for JSON, CBOR, MessagePack, and CESR field maps but is required for CESR fixed fields. This enables more than one type of CESR fixed field top-level ACDC CESR serialization that is unambiguously parseable. This seems to violate the schema-is-type convention in order to enable a parser to correctly parse a fixed field Message type.

Python dict of compact ACDC with message type, `t` field.

```python
{
  "v":  "ACDCCAAJSONAACD.",
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

#### ACDC message as top-level field map in CESR native format

When an ACDC message appears in CESR native format as a top-level field it shall use either of the CESR count codes, `-G##` or  `-0G#####` at the top-level. The top-level fields (labels and values) that appear shall appear in the following order: `[ v, t, d, u, i, rd, s, a, A, e, r]`. The required fields are `[v, t, d, i, s]`. The rules for the appearance of optional fields are the same as those defined above for the other serialization kinds. The major difference here is that the Version field value is a CESR primitive that provides the protocol type and the version. It does not provide a serialization kind or length. This is already indicated by the count code, `-G##` or  `-0G#####`.

#####  Compact Private ACDC with top-level field map in CESR native format

For clarity the first column provides the equivalent label value for the other serialization kinds (JSON, CBOR, MGPK). The actual label is the CESR encoded label in the second column.

| Field Label | Label Value| Field or Count Value  | Description |
|:--------:|:--------:|:-------|:------|
| NA |  NA | `-G##` or `-0G#####` | Count code for CESR native  top-level field map signable message |
| `v` | `0J_v` | `YACDCBAA` | Protocol Version primitive (ACDC 2.00) |
| `t` | `0J_t` | `Xacd` | Message type primitive |
| `d` |  `0J_d` |`EGgbiglDXNE0GC4NQq-hiB5xhHKXBxkiojgBabiu_JCk` | SAID of ACDC packet  |
| `u` |  `0J_u` |`0AGC4NQq-hiB5xhHKXBxkiK` | UUID (salt) of ACDC packet  |
| `i` |  `0J_i` |`EBabiu_JCkE0GbiglDXNB5C4NQq-hiGgxhHKXBxkiojg` | AID of issuer of ACDC |
| `rd` |  `0Krd` |`ECkE0GbiglDXNB5C4NQq-hiGgxhHKXBxkiojgBabiu_J` | SAID of revocation registry for ACDC |
| `s` |  `0J_s` |`EDXNB5C4NQq-hiGgxhHKXBxkiojgBabiu_JCkE0Gbigl` | SAID of schema section of ACDC packet  |
| `a` |   `0J_a` |`EC4NQq-hiGgbiglDXNB5xhHKXBxkiojgBabiu_JCkE0G` | SAID of schema of attribute section of ACDC packet |
| `e` |  `0J_e` |`EFXBxkiojgBabiu_JCkE0GC4NQq-hiGgbiglDXNB5xhH` | SAID of schema of edge section of ACDC packet |
| `r` |  `0J_r` |`EMiGgbiglDXNB5xhHFXBxkiojgBabiu_JCkE0GC4NQq-` | SAID of schema of rule section ACDC packet |

#### Section Message fields

| Label | Title | Description |
|:-:|:--|:--|
|`v`| Version String| Regexable format: `ACDCMmmKKKKSSSS.` that provides protocol type, Version, serialization type, size, and terminator. |
|`t`| Message Type| Three-character Message type |
|`d`| Digest (SAID) | Self-referential fully qualified cryptographic digest of enclosing map. |
|`s`| Schema| Either the SAID of a JSON Schema block or the block itself. |
|`a`| Attribute| Either the SAID of a block of Attributes or the block itself. |
|`A`| Attribute Aggregate| Either the aggregate of a selectively disclosable block of Attributes or the block itself. |
|`e`| Edge| Either the SAID of a block of Edges or the block itself.|
|`r`| Rule | Either the SAID a block of Rules or the block itself. |

Each section Message must have Version String, `v`, Message type, `t`,  and SAID, `d` fields in that order. The value of the SAID, `d` field is the said of the Message block itself not the SAID of the embedded section field value. The embedded section block's SAID, `d` field should match the section field value in the associated compact ACDC.

The remaining field is the appropriate section field for the Message type, as follows: 

- Schema, `s` field for the Schema, `sch` Message
- Attribute, `a` field for Atttribute, `att` Message
- Attribute aggregate, `A` field for the aggregate, `agg` Message
- Edge, `e` field for the Edge, `edg` Message
- Rule, `r` field for the Rule, `rul` Message

For the following Messages, except for the Attribute aggregate variant, assume that the associated compact ACDC is as follows:
Compact form with Attribute section:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

For the Attribute aggregate variant below, assume that the associated compact ACDC is as follows:

Compact form with Attribute aggregate section:

```json
{
  "v":  "ACDCCAAJSONAACD.",
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

#### Schema section Message

The Schema, `s` field value is the expanded Schema section from the associated ACDC. Notice that the value of the `$id` field within the Schema subblock matches the value of the Schema, `s` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD.",
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

#### Attribute section Message

The Attribute, `a` field value is the expanded Attribute section from the associated ACDC. Notice that the value of the `d` field within the Attribute subblock matches the value of the Attribute, `a` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD.",
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

The Attribute aggregate, `A` field value is the expanded Attribute aggregate section from the associated ACDC. Notice that the value of the Attribute aggregate, `A` field in the associated ACDC above, is computed as the digest of concatenated digests of the elements of the selectively disclosable Array (see Annex on Selective Disclosure).

```json
{
  "v": "ACDCCAAJSONAACD.",
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

The Edge, `e` field value is the expanded Edge section from the associated ACDC. Notice that the value of the `d` field within the Edge subblock matches the value of the Edge, `e` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD.",
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

The Rule, `r` field value is the expanded Rules section from the associated ACDC. Notice that the value of the `d` field within the Rule subblock matches the value of the Rule, `r` field in the associated ACDC above.

```json
{
  "v": "ACDCCAAJSONAACD.",
  "t": "rul", 
  "d":  "EBWNHdSXCJnFJL5OuQPyM5K0neuniccMBdXt3gIXOf2B",
  "r": 
  {
    "d": "EH3dCdoFOLBe71iheqcywJcnjtJtQIYPvAu6DZIl3MOR",
    "disclaimers":
    {
      "l": "The person or legal entity identified by this ACDC's Issuer AID (Issuer) makes the following disclaimers:",
      "warrantyDisclaimer": "Issuer provides this ACDC on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE",
      "liabilityDisclaimer": "In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall the Issuer be liable for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this credential. "
    },
    "permittedUse": "The person or legal entity identified by the ACDC's Issuee AID (Issuee) agrees to only use the information contained in this ACDC for non-commercial purposes."
  }
}
```

### ACDC Examples 

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

Composed Schema that supports both public compact and uncompacted variants

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
