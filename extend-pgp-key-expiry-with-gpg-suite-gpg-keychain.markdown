---
title: How to extend PGP expiry date with GPG Suite (GPG Keychain)
permalink: /extend-pgp-key-expiry-with-gpg-suite-gpg-keychain/
layout: page
---

## Open GPG Keychain

From the Mac applications drawer, open the GPG Keychain app.

You should see a list of all the keys that you've contacted.

![GPG Keychain showing PGP keys](/img/gpg-keychain-showing-keys.png){: .img-responsive }

**TIP:** I like to display `Name`, `Fingerprint` and `Expiry` as columns. By default GPG Keychain shows the unsafe, short `Key ID` which we should ignore. You can tweak the columns by right clicking on the column headers and ticking the columns you want.

## Find your own key

Check the box in the bottom right labelled `Show secret keys only` to limit the list of keys to your own.

Select your key and click the `Details` button. You should see a panel on the right showing details about your key.

![GPG Keychain showing my PGP key](/img/gpg-keychain-showing-pgp-key.png){: .img-responsive }

## Change expiration date

In the details panel you should see a field called `Expires` with a date and a `Change` button.

Click `Change` and you can edit the expiry date.

![GPG Keychain change expiry window](/img/gpg-keychain-showing-expiry-dialog.png){: .img-responsive }

Choose a time period. I personally recommend 3 months to 1 year.

Select `Change expiration date` and follow any prompts.

## Push your updated key to the keyservers

To tell the world about your new key expiry date, you'll need to send it to the keyservers.

Right click on the key and select `Send public key to keyserver`

## Remind your contacts to refresh their keys

Your contacts will need to get your updated key from the keysevers by refreshing their keys. Some software does this automatically.

In any case, if a contact says your key has expired, you'll know what to tell them.

If this didn't work, you could alternatively try [the GnuPG guide][gpg-guide].

## Help me improve this page

{% include pgp_user_research_callout.markdown %}

*Was this helpful?* I'd love to [hear from you!][email]

[email]: mailto:paul@paulfurley.com
[gpg-guide]: /extend-pgp-key-expiry-with-gpg/
