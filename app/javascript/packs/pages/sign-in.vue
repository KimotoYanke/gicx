<template lang="pug">
div
    gicx-navbar
    b-container.mt-5
        sign-in-form
</template>

<script>
export default {
    data: function () {
        return {
        }
    },
    components: {
        'gicx-navbar': require('../components/GicxNavbar.vue').default,
        'sign-in-form': require('../components/SignInForm.vue').default
    }
}
</script>

<style scoped>
</style>
