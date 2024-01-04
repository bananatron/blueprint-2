// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as ActionCable from '@rails/actioncable';
window.ActionCable = ActionCable;
window.Cable = ActionCable.createConsumer(`${window.rails_env == 'production' ? 'wss://www.' : 'ws://'}${window.application_host}/cable`);

// import Rails from '@rails/ujs';
// Rails.start();
