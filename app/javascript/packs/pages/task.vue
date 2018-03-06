<template lang="pug">
div
    gicx-navbar
    b-container.mt-5
        h1 {{ task.name }}
        h4 {{ subjectName }}
        task-info(:task='task', :subject-name='subjectName' v-if='grade!=0')
        submission-list(:task='task', :subject-name='subjectName' v-if='grade==0')
</template>

<script>
import {mapState} from 'vuex'
export default {
    data () {
        return {
        }
    },
    components: {
        'gicx-navbar': require('../components/GicxNavbar.vue').default,
        'task-info': require('../components/TaskInfo.vue').default,
        'submission-list': require('../components/SubmissionList.vue').default

    },
    computed: {
        subjectId () {
            return this.$route.params.subject * 1
        },
        subjectName () {
            return this.subjects.find(s => {
                return s.id === this.subjectId
            }).name
        },
        taskId () {
            return this.$route.params.task * 1
        },
        task () {
            return this.subjects.find(s => {
                return s.id === this.subjectId
            }).tasks.find(t => {
                return t.id === this.taskId
            })
        },
        ...mapState('user', [
            'subjects',
            'grade'
        ])
    }
}
</script>

<style scoped>
</style>
