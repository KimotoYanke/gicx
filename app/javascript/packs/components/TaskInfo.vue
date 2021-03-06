<template lang="pug">
div.mt-1
    h2 {{ remaining }}
    dl
        dt 教科
        dd {{ subjectName }}
        dt 期限
        dd {{ localUntil }}
    ul
      li(v-for="s in mySubmissions") {{ formatJapaneseFromString(s.created_at) }} に提出しています。
        template(v-if="s.is_passed == true") 合格
        template(v-if="s.is_passed == false") 不合格
        template(v-if="s.is_passed == null") 未採点
    b-file.bg-white(type="file" v-model="file" ref="file")
    b-btn(@click="submit") 提出
</template>

<script>
import {mapGetters, mapState} from 'vuex'
import jaLocale from 'date-fns/locale/ja'
import { format, isPast, parse } from 'date-fns'
const formatJapanese = d => format(d, 'YYYY/MM/DD(dd) HH:mm:ss', {locale: jaLocale})
const formatJapaneseFromString = d => formatJapanese(parse(d))
const formatJapaneseDuration = (d, n) => {
    const diff = Math.abs(d - n)

    const second = ((diff / 1000) % 60).toFixed(3)

    const minute = Math.floor(diff / (1000 * 60)) % 60

    const hour = Math.floor(diff / (1000 * 60 * 60)) % 24

    const day = Math.floor(diff / (1000 * 60 * 60 * 24))

    return `${day}日 ${hour}時間 ${minute}分 ${second}秒`
}

export default {
    name: 'task-info',
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
        mySubmissions () {
            return this.task.submissions.filter(s =>
                s.uid === this.uid
            )
        },
        ...mapGetters([
            'axiosInstance'
        ]),
        ...mapState('user', [
            'uid'
        ])
    },
    methods: {
        submit () {
            const readAsBase64 = file => {
                const r = new FileReader()
                return new Promise((resolve, reject) => {
                    r.onloadend = () => {
                        resolve(r.result.split(',')[1])
                    }
                    r.onerror = err => {
                        reject(err)
                    }
                    r.readAsDataURL(file)
                })
            }
            const getExt = filename => {
                const arr = filename.split(/\./g)
                return arr[arr.length - 1]
            }
            readAsBase64(this.file).then(d => {
                const ext = getExt(this.file.name)
                return this.axiosInstance.post('/submission/', {
                    'decoded_file': d,
                    subject: this.task.subject_id,
                    task: this.task.id,
                    user: this.uid,
                    ext
                }).catch(err => console.log(err))
            }).then(() => {
                this.$store.dispatch('user/getSubjects')
                this.file = null
            })
        },
        formatJapaneseFromString
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
</style>
