import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';

export default class EventForm extends Component {
  @service api;
  @service router;

  @tracked name = this.args.event?.name ?? '';
  @tracked description = this.args.event?.description ?? '';
  @tracked occurredOn = this.args.event?.occurred_on ?? '';
  @tracked errors = null;
  @tracked saving = false;

  get isEditing() {
    return !!this.args.event;
  }

  updateName = (e) => (this.name = e.target.value);
  updateDescription = (e) => (this.description = e.target.value);
  updateOccurredOn = (e) => (this.occurredOn = e.target.value);

  submit = async (e) => {
    e.preventDefault();
    this.errors = null;
    this.saving = true;

    const data = {
      name: this.name,
      description: this.description,
      occurred_on: this.occurredOn,
    };

    try {
      let result;
      if (this.isEditing) {
        result = await this.api.updateEvent(this.args.event.slug, data);
      } else {
        result = await this.api.createEvent(data);
      }
      this.router.transitionTo('events.show', result.event.slug);
    } catch (err) {
      this.errors = err.body?.errors ?? { base: ['Something went wrong'] };
    } finally {
      this.saving = false;
    }
  };

  <template>
    <form class="event-form" {{on "submit" this.submit}}>
      {{#if this.errors}}
        <div class="form-errors">
          {{#each-in this.errors as |field messages|}}
            {{#each messages as |message|}}
              <p class="error">{{field}} {{message}}</p>
            {{/each}}
          {{/each-in}}
        </div>
      {{/if}}

      <div class="form-field">
        <label for="name">Name</label>
        <input
          id="name"
          type="text"
          value={{this.name}}
          placeholder="e.g. Quit Smoking"
          required
          {{on "input" this.updateName}}
        />
      </div>

      <div class="form-field">
        <label for="description">Description</label>
        <input
          id="description"
          type="text"
          value={{this.description}}
          placeholder="A short description"
          required
          {{on "input" this.updateDescription}}
        />
      </div>

      <div class="form-field">
        <label for="occurred-on">Date</label>
        <input
          id="occurred-on"
          type="date"
          value={{this.occurredOn}}
          required
          {{on "input" this.updateOccurredOn}}
        />
      </div>

      <div class="form-actions">
        <button type="submit" class="btn" disabled={{this.saving}}>
          {{if this.isEditing "Update Event" "Create Event"}}
        </button>
        {{#if this.isEditing}}
          <LinkTo @route="events.show" @model={{@event.slug}} class="btn btn-secondary">Cancel</LinkTo>
        {{else}}
          <LinkTo @route="events.index" class="btn btn-secondary">Cancel</LinkTo>
        {{/if}}
      </div>
    </form>
  </template>
}
