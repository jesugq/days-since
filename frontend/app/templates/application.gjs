import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';

<template>
  {{pageTitle "Days Since"}}

  <nav class="navbar">
    <LinkTo @route="events.index" class="nav-brand">Days Since</LinkTo>
    <LinkTo @route="events.new" class="nav-link">+ New Event</LinkTo>
  </nav>

  <main class="container">
    {{outlet}}
  </main>
</template>
