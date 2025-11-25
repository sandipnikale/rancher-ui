<script>
import ResourceTable from '@shell/components/ResourceTable';
import { STATE, NAME, AGE } from '@shell/config/table-headers';

export default {
  name: 'ListRancherSupportBundle',
  components: { ResourceTable },
  props: {
    schema: {
      type: Object,
      required: true,
    },
  },
  computed: {
    headers() {
      return [
        STATE,
        NAME,
        {
          name: 'clusters',
          labelKey: 'tableHeaders.clusters',
          value: 'spec.clusters',
          formatter: 'ArrayLength',
        },
        {
          name: 'state',
          labelKey: 'tableHeaders.bundleState',
          value: 'status.state',
        },
        {
          name: 'message',
          labelKey: 'tableHeaders.message',
          value: 'status.message',
        },
        AGE,
      ];
    },
  },
};
</script>

<template>
  <ResourceTable :schema="schema" :headers="headers" />
</template>
