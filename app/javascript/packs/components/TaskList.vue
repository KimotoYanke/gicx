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
                li(class="no-bullet", v-if="isTeacher")
                    b-form(@submit="submit(subject)")
                        h5.mt-2 新規追加
                        b-form-group(label="名前", :label-cols="1", horizontal, size="sm")
                            b-input(v-model="subject.newName")
                        b-form-group(label="期限", :label-cols="1", horizontal, size="sm")
                            b-input(type="datetime-local", v-model="subject.newDate")
                        b-btn(type="submit") 送信
</template>

<script>
import {mapState, mapGetters} from 'vuex'
export default {
    name: 'task-list',
    data () {
        return {
        }
    },
    computed: {
        ...mapState('user', [
            'subjects'
        ]),
        ...mapGetters('user', [
            'isTeacher'
        ]),
        ...mapGetters([
            'axiosInstance'
        ])
    },
    methods: {
        submit (subject) {
            console.log(subject.newDate, subject.newName)
            this.axiosInstance.post('/task/', {
                'subject_id': subject.id,
                name: subject.newName,
                until: subject.newDate
            }).then(() => {
                this.$store.dispatch('user/getSubjectsForTeachers')
            })
        }
    }
}
</script>

<style scoped>
h4 {
    display: inline;
}
.no-bullet {
    list-style-type: none;
}
</style>
