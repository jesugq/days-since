import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class EventsIndexRoute extends Route {
  @service api;

  async model() {
    const data = await this.api.fetchEvents();
    return data.events;
  }
}
