<script>
import ResourceTabs from '@shell/components/form/ResourceTabs';
import Tab from '@shell/components/Tabbed/Tab';
import SortableTable from '@shell/components/SortableTable';
import Banner from '@shell/components/Banner';

export default {
  name: 'DetailRancherSupportBundle',
  components: {
    ResourceTabs,
    Tab,
    SortableTable,
    Banner,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
  },
  computed: {
    clustersHeaders() {
      return [
        {
          name: 'cluster',
          labelKey: 'tableHeaders.cluster',
          value: 'cluster',
        },
      ];
    },
    clustersRows() {
      return (this.value.spec.clusters || []).map(cluster => ({ cluster }));
    },
    canDownload() {
      return this.value.status?.state === 'Completed';
    },
    downloadUrl() {
      // Construct the download URL using Kubernetes API proxy
      // Format: /k8s/clusters/<cluster-id>/api/v1/namespaces/<namespace>/services/<service-name>:<port>/proxy/bundle.zip
      const namespace = this.value.metadata.namespace || 'default';
      const serviceName = `${this.value.metadata.name}-collector`;
      const clusterId = this.$store.getters['currentCluster']?.id || 'local';
      
      return `/k8s/clusters/${clusterId}/api/v1/namespaces/${namespace}/services/${serviceName}:8080/proxy/bundle.zip`;
    },
  },
  methods: {
    downloadBundle() {
      if (this.canDownload) {
        window.location.href = this.downloadUrl;
      }
    },
  },
};
</script>

<template>
  <div>
    <h2>{{ value.metadata.name }}</h2>
    
    <div class="row mb-20">
      <div class="col span-12">
        <Banner
          v-if="value.status?.message"
          :color="value.status.state === 'Failed' ? 'error' : 'info'"
        >
          {{ value.status.message }}
        </Banner>
      </div>
    </div>

    <div class="row mb-20">
      <div class="col span-6">
        <div class="labeled-input">
          <label>{{ t('rancherSupportBundle.state.label') }}</label>
          <div>{{ value.status?.state || 'Pending' }}</div>
        </div>
      </div>
      <div class="col span-6">
        <div class="labeled-input">
          <label>{{ t('rancherSupportBundle.storageClassName.label') }}</label>
          <div>{{ value.spec?.storageClassName || 'N/A' }}</div>
        </div>
      </div>
    </div>

    <div class="row mb-20">
      <div class="col span-12">
        <button
          :disabled="!canDownload"
          class="btn role-primary"
          @click="downloadBundle"
        >
          {{ t('rancherSupportBundle.download.label') }}
        </button>
        <span v-if="!canDownload" class="text-muted ml-10">
          {{ t('rancherSupportBundle.download.notReady') }}
        </span>
      </div>
    </div>

    <ResourceTabs v-model="value" :mode="'view'">
      <Tab name="clusters" :label="t('rancherSupportBundle.clusters.label')">
        <SortableTable
          :rows="clustersRows"
          :headers="clustersHeaders"
          key-field="cluster"
          :search="false"
          :paging="false"
        />
      </Tab>
    </ResourceTabs>
  </div>
</template>

<style lang="scss" scoped>
.labeled-input {
  label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
  }
  div {
    padding: 10px;
    background: var(--input-bg);
    border: 1px solid var(--input-border);
    border-radius: 3px;
  }
}
</style>
