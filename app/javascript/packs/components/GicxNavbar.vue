<template lang="pug">
b-navbar(type="dark" variant="info" fixed)
    router-link(is="b-navbar-brand" to="/") gicx
    b-navbar-nav.ml-auto
        router-link(v-if="isLogined" is="b-nav-item" to="/sign_in") サインイン
        b-nav-item(v-else) サインアウト
</template>

<script>
export default {
    name: 'gicx-navbar',
    data: function () {
        return {
            isLogined: true
        }
    }
}
</script>

<style scoped>
</style>
