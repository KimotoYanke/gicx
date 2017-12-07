<template lang="pug">
div
    gicx-navbar
    b-container.mt-5
        task-list
        task-timeline
</template>

<script>
export default {
    data: function () {
        return {
        }
    },
    components: {
        'gicx-navbar': require('../components/GicxNavbar.vue').default,
        'task-list': require('../components/TaskList.vue').default,
        'task-timeline': require('../components/TaskTimeline.vue').default
    }
}
</script>

<style scoped>
</style>
