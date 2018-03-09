<template lang="pug">
div.mt-1
    h2 {{ remaining }}
    dl
        dt 教科
        dd {{ subjectName }}
        dt 期限
        dd {{ localUntil }}
    ul
        li(v-for="s of submissions[task.id]")
            div
              h2 {{ s.user.number_in_class }}
              b-btn(@click="download(s.id)", size="sm") ダウンロード
            div
                h4(v-if="s.is_confirming") 提出済
                h4(v-else) 未提出
            div
                template(v-if="s.is_passed == true")
                    h4 合格
                    b-btn(@click="submit(s, false)") 不合格
                template(v-if="s.is_passed == false")
                    h4 不合格
                    b-btn(@click="submit(s, true)") 合格
                template(v-if="s.is_passed == null")
                    h4 未採点
                    b-btn(@click="submit(s, true)") 合格
                    b-btn(@click="submit(s, false)") 不合格

</template>

<script>
import {mapGetters, mapState} from 'vuex'
import jaLocale from 'date-fns/locale/ja'
import { format, isPast } from 'date-fns'
const formatJapanese = d => format(d, 'YYYY/MM/DD(dd) HH:mm:ss', {locale: jaLocale})
const formatJapaneseDuration = (d, n) => {
    const diff = Math.abs(d - n)

    const second = ((diff / 1000) % 60).toFixed(3)

    const minute = Math.floor(diff / (1000 * 60)) % 60

    const hour = Math.floor(diff / (1000 * 60 * 60)) % 24

    const day = Math.floor(diff / (1000 * 60 * 60 * 24))

    return `${day}日 ${hour}時間 ${minute}分 ${second}秒`
}

export default {
    name: 'submission-list',
    data () {
        return {
            now: new Date(), // Vuejsの再描画イベントを起こすためnowはdata化
            file: null
        }
    },
    props: {
        task: Object,
        subjectName: String
    },
    mounted () {
        const loop = () => {
            window.requestAnimationFrame(loop)
            this.now = new Date()
        }
        loop()
    },
    computed: {
        localUntil () {
            return formatJapanese(this.task.until)
        },
        remaining () {
            if (isPast(this.task.until)) {
                return `締切より${formatJapaneseDuration(this.task.until, this.now)}経過`
            } else {
                return `あと${formatJapaneseDuration(this.task.until, this.now)}`
            }
        },
        ...mapGetters([
            'axiosInstance'
        ]),
        ...mapState('user', [
            'submissions'
        ])
    },
    methods: {
        submit (submission, isPassed) {
            this.axiosInstance.get('/submission/pass', {
                params: {
                    submission_id: submission.id,
                    is_passed: isPassed
                }
            }).then(() => {
                this.$store.dispatch('user/getSubjectsForTeachers')
            })
        },
        download (sid) {
            open('/submission/download?submission_id=' + sid)
        }
    }
}
</script>

<style scoped>
dt {
    font-size: 16px;
}
dd {
    font-size: 16px;
    margin-left: 2rem;
}
ul {
    list-style-type: none;
}
</style>
