<template lang="pug">
div.mt-5
    h3 タイムライン
    ul.timeline
        li.task(v-for="task of sortedTasks")
            .date {{ task.until.toLocaleString('ja-JP') }}
            .content-wrapper
                .content
                    h4 {{ task.subject }}
                    h5 {{ task.name }}
</template>

<script>
export default {
    name: 'timeline',
    computed: {
        sortedTasks () {
            return [ // ここのは仮の
                {
                    subject: '国語',
                    name: 'レポート',
                    until: new Date(2017, 7, 10)
                },
                {
                    subject: '数学',
                    name: 'レポート',
                    until: new Date(2017, 7, 11)
                }

            ]
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
    top: calc(50% - 0.5rem);
    position: absolute;
}
.content-wrapper {
    left: 9rem;
    top: 0px;
    position: relative;
    display: inline-block;
    min-width: 30rem;
}
.content-wrapper::before {
    left: calc(7rem - 9rem + 0.3rem / 2);
    top: calc(50% - 0.5rem + 1px);
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
    margin-left: 1rem;
    border-radius: 1rem;
}
/* 吹き出しの<の部分 */
.content::before {
    content: " ";
    height: 0;
    position: absolute;
    top: calc(50% - 1rem);
    width: 0;
    z-index: 1;
    left: 0;
    width: 2rem;
    height: 2rem;
    border-top: 1px solid var(--tl-color);
    border-right: 1px solid var(--tl-color);
    background-color: white;
    transform: rotate(-135deg);
}
</style>
