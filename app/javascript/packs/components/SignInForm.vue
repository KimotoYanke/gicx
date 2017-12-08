<template lang="pug">
div.mt-5
    h3 サインイン
    b-form
        b-form-group(label="Email" description="メールアドレス")
            b-form-input(type="email" v-model="email" required)
        b-form-group(label="パスワード")
            b-form-input(type="password" v-model="password" required)
        b-button(@click="signIn") 送信
</template>

<script>
import axios from 'axios'
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
            axios.create({
                withCredentials: true
            }).post('/auth/sign_in', {
                email: this.email,
                password: this.password
            }).then(res => {
                console.log(res.headers)
                const accessToken = res.headers['access-token']
                const client = res.headers['client']
                const uid = res.headers['uid']
                this.$store.commit('setToken', {accessToken, client, uid})
            })
        }
    }
}
</script>

<style scoped>
h4 {
    display: inline;
}
</style>
