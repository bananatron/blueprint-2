# Blueprint 2

A Rails 7 starter w/ the following defaults:

- Deployable to Render
- Devise Installed
- ActionCable ready
- No JS build (importmaps instead)
- Alpine.js example for reactivity
- Tachyons for styles
- Turbo morph ready
- GoodJob for background jobs


## Setup Postmark
- Uncomment gem
- Uncomment `production.rb`
- Set `POSTMARK_API_TOKEN`


## Setup Digital Ocean
- Uncomment gem
- Uncomment `aws_digital_ocean.rb`
- Set ENV vars in said file

## Setup Stripe
- Edit StripeCharges
- Edit StripeController


## Supplementary
- [A quick guide on Turbo morph and broadcasting](https://www.youtube.com/watch?v=hKKycPLN-sk)
- [How importmaps work w/ Rails](https://github.com/rails/importmap-rails)