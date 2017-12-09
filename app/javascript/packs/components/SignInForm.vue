<template lang="pug">
div.mt-5
    h3 サインイン
    b-form(@submit="signIn")
        b-form-group(label="Email" description="メールアドレス")
            b-form-input(type="email" v-model="email" required)
        b-form-group(label="パスワード")
            b-form-input(type="password" v-model="password" required)
        b-button(type="submit") 送信
</template>

<script>
import axios from 'axios'
import {mapMutations, mapGetters} from 'vuex'
export default {
    name: 'sign-in-form',
    data () {
        return {
            email: '',
            password: ''
        }
    },
    methods: {
        signIn () {
            this.axiosInstance.post('/auth/sign_in', {
                email: this.email,
                password: this.password
            }).then(res => {
                if (res.status === 401) {
                } else {
                    const accessToken = res.headers['access-token']
                    const client = res.headers['client']
                    const uid = res.headers['uid']
                    this.setToken({accessToken, client, uid})
                }
            })
        },
        ...mapMutations('user', [
            'setToken'
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
