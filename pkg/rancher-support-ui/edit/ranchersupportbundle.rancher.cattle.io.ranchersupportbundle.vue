<script>
import CreateEditView from '@shell/mixins/create-edit-view';
import CruResource from '@shell/components/CruResource';
import NameNsDescription from '@shell/components/form/NameNsDescription';
import LabeledInput from '@shell/components/form/LabeledInput';
import ArrayList from '@shell/components/form/ArrayList';

export default {
  name: 'EditRancherSupportBundle',
  components: {
    CruResource,
    NameNsDescription,
    LabeledInput,
    ArrayList,
  },
  mixins: [CreateEditView],
  data() {
    if (!this.value.spec) {
      this.$set(this.value, 'spec', {});
    }
    if (!this.value.spec.clusters) {
      this.$set(this.value.spec, 'clusters', []);
    }
    if (!this.value.spec.storageClassName) {
      this.$set(this.value.spec, 'storageClassName', '');
    }
    return {};
  },
};
</script>

<template>
  <CruResource
    :done-route="doneRoute"
    :mode="mode"
    :resource="value"
    :subtypes="[]"
    :validation-passed="true"
    :errors="errors"
    @error="e=>errors = e"
    @finish="save"
    @cancel="done"
  >
    <NameNsDescription
      v-model="value"
      :mode="mode"
      :namespaced="true"
    />

    <div class="row mb-20">
      <div class="col span-12">
        <ArrayList
          v-model="value.spec.clusters"
          :title="t('rancherSupportBundle.clusters.label')"
          :add-label="t('rancherSupportBundle.clusters.add')"
          :mode="mode"
        />
      </div>
    </div>

    <div class="row mb-20">
      <div class="col span-6">
        <LabeledInput
          v-model="value.spec.storageClassName"
          :label="t('rancherSupportBundle.storageClassName.label')"
          :mode="mode"
          :placeholder="t('rancherSupportBundle.storageClassName.placeholder')"
        />
      </div>
    </div>
  </CruResource>
</template>
