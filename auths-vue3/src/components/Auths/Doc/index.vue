<template>
  <div>
    <svg-icon icon-class="question" @click="goto" />
  </div>
</template>

<script setup>
const url = ref('http://doc.auths.vip/auths-cloud');

function goto() {
  window.open(url.value)
}
</script>