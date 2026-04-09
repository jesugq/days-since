import { LinkTo } from '@ember/routing';

<template>
  <h1>Events</h1>

  {{#if @model.length}}
    <ul class="events-list">
      {{#each @model as |event|}}
        <li class="event-card">
          <LinkTo @route="events.show" @model={{event.slug}} class="event-link">
            <span class="days-count">{{event.days_since}}</span>
            <span class="days-label">days since</span>
            <span class="event-name">{{event.name}}</span>
          </LinkTo>
        </li>
      {{/each}}
    </ul>
  {{else}}
    <p class="empty-state">No events yet. Create one to start tracking!</p>
  {{/if}}
</template>
