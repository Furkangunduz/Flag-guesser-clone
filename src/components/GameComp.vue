<template>
    <start-comp v-if="!isGameStarted" />
    <question-comp v-if="isGameStarted && !isGameFinished.finished" />
    <finish-game
        @restart="reset"
        v-if="isGameStarted && isGameFinished.finished"
    />
</template>
<script>
import QuestionComp from '@/components/QuestionComp.vue';
import StartComp from '@/components/StartComp.vue';
import FinishGame from './FinishComp.vue';
import countries from '../../country_names';

export default {
    components: {
        QuestionComp,
        StartComp,
        FinishGame,
    },
    data() {
        return {
            isGameStarted: false,
            resetGame: { reset: false },
            isGameFinished: { finished: false },
            userName: { userName: '' },
            countriesLen: countries.length,
            score: { score: 0 },
            leaderBoard: {
                board: [],
            },
        };
    },
    methods: {
        startGame(userName) {
            if (!userName) {
                alert('please write username');
                return;
            }
            this.userName.userName = userName;
            this.isGameStarted = true;
        },
        reset() {
            this.isGameFinished.finished = false;
            this.isGameStarted = false;
        },
    },
    provide() {
        return {
            startGame: this.startGame,
            isGameFinished: this.isGameFinished,
            userName: this.userName,
            countriesLen: this.countriesLen,
            score: this.score,
            db: this.leaderBoard,
        };
    },
};
</script>
