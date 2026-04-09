import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class EventsShowRoute extends Route {
  @service api;

  async model(params) {
    const data = await this.api.fetchEvent(params.event_slug);
    return data.event;
  }
}
