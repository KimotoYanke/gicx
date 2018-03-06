<template lang="pug">
b-navbar.justify-content-start(type="dark" variant="info" fixed toggleable="md")
    b-navbar-toggle.mr-2(target="navbar-collapse")
    router-link.brand(is="b-navbar-brand" to="/") gicx
    b-collapse(is-nav id="navbar-collapse")
        b-navbar-nav
        b-navbar-nav.ml-auto
            template(v-if="isLogined")
                b-nav-item {{ grade || '' }}{{ grade ? '-' : '' }}{{ department }}
                b-nav-item(@click="signOut") サインアウト
            router-link(v-else is="b-nav-item" to="/sign_in") サインイン
</template>

<script>
import {mapActions, mapState} from 'vuex'
export default {
    name: 'gicx-navbar',
    created () {
        this.$store.dispatch('user/checkSignIned')
    },
    data: () => {
        return {
        }
    },
    methods: {
        ...mapActions('user', [
            'checkSignIned',
            'signOut'
        ])
    },
    computed: {
        ...mapState('user', {
            isLogined: state => state.success,
            grade: state => state.grade,
            department: state => state.department
        })
    }

}
</script>

<style scoped>
.brand {

}
</style>
