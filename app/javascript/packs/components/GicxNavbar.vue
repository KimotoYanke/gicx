<template lang="pug">
b-navbar(type="dark" variant="info" fixed)
    b-navbar-brand gicx
    b-navbar-nav.ml-auto
        b-nav-item(v-if="isLogined") ログイン
        b-nav-item(v-else) ログアウト
</template>

<script>
export default {
    name:'gicx-navbar',
    data: function () {
        return {
            isLogined: true
        }
    }
}
</script>

<style scoped>
</style>
