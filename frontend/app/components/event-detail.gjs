import Component from '@glimmer/component';
import { service } from '@ember/service';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';

export default class EventDetail extends Component {
  @service api;
  @service router;

  delete = async () => {
    if (!confirm('Are you sure you want to delete this event?')) return;

    await this.api.deleteEvent(this.args.event.slug);
    this.router.transitionTo('events.index');
  };

  <template>
    <article class="event-detail">
      <h1>{{@event.name}}</h1>

      <div class="days-display">
        <span class="days-count-large">{{@event.days_since}}</span>
        <span class="days-label">days since {{@event.occurred_on}}</span>
      </div>

      <p class="event-description">{{@event.description}}</p>

      <div class="event-actions">
        <LinkTo @route="events.edit" @model={{@event.slug}} class="btn">Edit</LinkTo>
        <button type="button" class="btn btn-danger" {{on "click" this.delete}}>Delete</button>
        <LinkTo @route="events.index" class="btn btn-secondary">Back</LinkTo>
      </div>
    </article>
  </template>
}
