<template lang="pug">
div.mt-5
    h3 タイムライン
    ul.timeline
        li.task(v-for="task of sortedTasks")
            .date {{ task.until.toLocaleString('ja-JP') }}
            .content-wrapper
                .content
                    h4 {{ task.homeroom.grade }} - {{ task.homeroom.department }} {{ task.subject }} 
                    h5 {{ task.name }}
</template>

<script>
import { mapGetters } from 'vuex'
export default {
    name: 'timeline',
    computed: {
        ...mapGetters('user', [
            'tasks'
        ]),
        sortedTasks () {
            return this.tasks.sort((a, b) =>
                a.until - b.until
            )
        }
    }
}
</script>

<style scoped>

:root {
  --tl-color: black;
}
.timeline {
    padding: 0px;
    position: relative;
}
.timeline::after {
    content: '';
    left: 7.5rem;
    position: absolute;
    width: 0.3rem;
    border: 1px solid var(--tl-color);
    border-radius: calc(0.3rem / 2);
    top: 0;
    bottom: 0;
}
.task {
    overflow: hidden;
    margin: 0;
    margin-bottom: 1rem;
    position: relative;
}
.date {
    top: calc(50% - 0.775rem);
    position: absolute;
}
.content-wrapper {
    left: 9rem;
    top: 0px;
    position: relative;
    display: inline-block;
    min-width: 50%;
}
/* 丸の部分 */
.content-wrapper::before {
    left: calc(7rem - 9rem + 0.3rem / 2);
    top: calc(50% - 0.75rem + 1px);
    content: " ";
    width: 1rem;
    height: 1rem;
    border: 1px solid var(--tl-color);
    border-radius: 50%;
    position: absolute;
    background-color: white;
    z-index: 2;
}
.content{
    border: 1px solid var(--tl-color);
    padding: 1rem;
    margin-left: calc(0.2rem + 0.5px);
    border-radius: 0.5rem;
}
/* 吹き出しの<の部分 */
.content::before {
    content: " ";
    height: 0;
    position: absolute;
    top: calc(50% - 0.5rem);
    width: 0;
    z-index: 1;
    left: 0;
    width: 0.5rem;
    height: 0.5rem;
    border-top: 1px solid var(--tl-color);
    border-right: 1px solid var(--tl-color);
    background-color: white;
    transform: rotate(-135deg);
}
</style>
