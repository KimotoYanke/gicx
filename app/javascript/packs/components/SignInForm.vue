<template lang="pug">
div.mt-5
    h3 サインイン
    b-form(@submit="signIn")
        b-form-group(label="学籍番号")
            b-form-input(type="number" v-model="uid" required)
        b-form-group(label="パスワード")
            b-form-input(type="password" v-model="password" required)
        b-button(type="submit") 送信
</template>

<script>
import {mapMutations, mapGetters, mapActions} from 'vuex'
export default {
    name: 'sign-in-form',
    data () {
        return {
            uid: '',
            password: ''
        }
    },
    methods: {
        signIn () {
            this.$store.commit('user/resetAll')
            this.axiosInstance.post('/auth/sign_in', {
                uid: this.uid,
                password: this.password
            }).then(res => {
                if (res.status === 401) {
                } else {
                    const accessToken = res.headers['access-token']
                    const client = res.headers['client']
                    const uid = res.headers['uid']
                    this.setToken({accessToken, client, uid})
                }
            }).then(() => {
                this.checkSignIned()
            })
            return false
        },
        ...mapMutations('user', [
            'setToken'
        ]),
        ...mapActions('user', [
            'checkSignIned'
        ])
    },
    computed: {
        ...mapGetters([
            'axiosInstance'
        ])
    }
}
</script>

<style scoped>
h4 {
    display: inline;
}
</style>
