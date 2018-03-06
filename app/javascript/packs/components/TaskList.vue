<template lang="pug">
div.mt-5
    h3 現在の課題
    div
        .subject(v-for="subject of subjects")
            h5
                | {{ subject.homeroom.grade }} - {{ subject.homeroom.department }}
            h4
                | {{ subject.name }}
            ul
                li(v-for="task of subject.tasks")
                    router-link(:to='"task/"+subject.id+"/"+task.id') {{ task.name }}
</template>

<script>
import {mapState} from 'vuex'
export default {
    name: 'task-list',
    data () {
        return {
        }
    },
    computed: {
        ...mapState('user', [
            'subjects'
        ])
    }
}
</script>

<style scoped>
h4 {
    display: inline;
}
</style>
