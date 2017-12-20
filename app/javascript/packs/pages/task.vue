<template lang="pug">
div
    gicx-navbar
    b-container.mt-5
        h1 {{ task.name }}
        h4 {{ task.subject }}
        task-info(:task='task')
</template>

<script>
export default {
    data () {
        return {
        }
    },
    components: {
        'gicx-navbar': require('../components/GicxNavbar.vue').default,
        'task-info': require('../components/TaskInfo.vue').default
    },
    computed: {
        taskId () {
            return this.$route.params.id
        },
        task () {
            return {
                subject: '国語',
                id: 'a',
                name: 'レポート',
                until: new Date(2018, 7, 10, 13, 12)
            }
        }
    }
}
</script>

<style scoped>
</style>
