import EmberRouter from '@embroider/router';
import config from 'frontend/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('events', { path: '/' }, function () {
    this.route('new');
    this.route('show', { path: '/:event_slug' });
    this.route('edit', { path: '/:event_slug/edit' });
  });
});
