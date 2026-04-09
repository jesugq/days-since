import Service from '@ember/service';
import config from 'frontend/config/environment';

export default class ApiService extends Service {
  host = config.apiHost;

  async request(path, options = {}) {
    const url = `${this.host}${path}`;
    const response = await fetch(url, {
      headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
      ...options,
    });

    if (response.status === 204) return null;

    const body = await response.json();

    if (!response.ok) {
      const error = new Error(`HTTP ${response.status}`);
      error.body = body;
      throw error;
    }

    return body;
  }

  fetchEvents(params = {}) {
    const query = new URLSearchParams(params).toString();
    return this.request(`/events.json${query ? '?' + query : ''}`);
  }

  fetchEvent(slug) {
    return this.request(`/events/${slug}.json`);
  }

  createEvent(data) {
    return this.request('/events.json', {
      method: 'POST',
      body: JSON.stringify({ event: data }),
    });
  }

  updateEvent(slug, data) {
    return this.request(`/events/${slug}.json`, {
      method: 'PATCH',
      body: JSON.stringify({ event: data }),
    });
  }

  deleteEvent(slug) {
    return this.request(`/events/${slug}.json`, { method: 'DELETE' });
  }
}
