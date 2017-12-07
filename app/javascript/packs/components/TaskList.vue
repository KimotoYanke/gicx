<template lang="pug">
div.mt-5
    h3 現在の課題
    div
        .subject(v-for="subject of subjects")
            h4
                | {{ subject.name }}
            ul
                li(v-for="task of subject.tasks")
                    | {{ task.name }}
</template>

<script>
export default {
    name: 'task-list',
    data () {
        return {
        }
    },
    computed: {
        subjects () {
            return [ // ここのは仮の
                {
                    name: '国語',
                    tasks: [
                        {
                            name: 'レポート',
                            until: new Date(2017, 7, 10)
                        }
                    ]
                },
                {
                    name: '数学',
                    tasks: [
                        {
                            name: 'レポート',
                            until: new Date(2017, 7, 11)
                        }
                    ]
                }
            ]
        }
    }
}
</script>

<style scoped>
h4 {
    display: inline;
}
</style>
