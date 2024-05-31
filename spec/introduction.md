## Introduction
<!-- file name: introduction.md -->
::: issue
https://github.com/trustoverip/tswg-acdc-specification/issues/11
:::

One primary purpose of the ACDC protocol is to provide granular provenanced proof-of-authorship (authenticity) of their contained data via a tree or chain of linked ACDCs (technically a directed acyclic graph or DAG). Similar to the concept of a chain-of-custody, ACDCs provide a verifiable chain of proof-of-authorship of the contained data. This could enable an "authentic" web where all data on the web has verifiable proof-of-authorship. 

With a little additional syntactic sugar, this primary facility of chained (treed) proof-of-authorship (authenticity) is extensible to a chained (treed) verifiable authentic proof-of-authority (proof-of-authorship-of-authority). A proof-of-authority may be used to provide different types of verifiable authorizations such as, entitlements, permissions, rights, or credentials. A chained (treed) proof-of-authority enables delegation of authority and hence delegated authorizations. These proofs of authorship and/or authority provide provenance of an ACDC itself and, by association, any data that is so conveyed.

To elaborate, the dictionary definition of credential is "evidence of authority, status, rights, entitlement to privileges, etc."  Appropriately structured ACDCs may be used as credentials when their semantics provide verifiable evidence of authority. Chained ACDCs may provide delegated credentials.

Chains of ACDCs that merely provide proof-of-authorship (authenticity) of data may be appended to chains of ACDCs that provide proof-of-authority (delegation) to enable verifiable delegated authorized authorship of data.  This is also a vital facility for authentic data supply chains. Furthermore, any physical supply chain may be measured, monitored, regulated, audited, and/or archived by a data supply chain acting as a digital twin [[54]]. Therefore, ACDCs provide the critical enabling facility for an authentic data economy and, by association, an authentic real (twinned) economy.

ACDCs act as securely attributed (authentic) fragments of a distributed property graph (PG) [[56]] [[57]]. Thus, ACDCs may be used to construct knowledge graphs expressed as property graphs [[58]]. ACDCs enable securely-attributed and privacy-protecting knowledge graphs. Semantically modulated verifiable provenanceable graphs enable authenticatable, delegable, attenuable, and aggregable authorizations and attributions.

The ACDC specification (including its disclosure mechanisms) leverages two primary cryptographic operations, namely digests and digital signatures [[48]] [[52]]. These operations, when used in an ACDC, must have a security level, cryptographic strength, or entropy of approximately 128 bits [[53]]. (See [Annex A](#cryptographic-strength-and-security) for a discussion of cryptographic strength and security)

An important property of high-strength cryptographic digests is that a verifiable cryptographic commitment (such as a digital signature) to the digest of some data is equivalent to a commitment to the data itself. The digest enables confidentiality because secure attribution of the commitment to the digest may be verified without disclosing the digested data. Later, confidential disclosure of the digested data can be verified against the digest. ACDCs leverage this property to enable compact chains of ACDCs that commit to (anchor or seal) data via digests. The data actually contained in an ACDC, therefore, may be merely its digest. The digested data may thereby be equivalently but more compactly and confidentially authenticated and authorized by the chain of ACDCs.

There are several different variants of ACDCs. These enable different types of disclosure mechanisms that provide differing levels of protection from exploitation and enable functional privacy with provisional authentication. A notable feature of ACDCs is support for Contractually Protected Disclosure that provides more comprehensive privacy protection than mere Selective Disclosure alone might provide.


[//]: # (:::)

