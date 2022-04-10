<template>
	<start-page v-if="!isGameStarted" />
	<question-comp v-if="isGameStarted && !isGameFinished.finished" />
	<finish-game @restart="reset" v-if="isGameStarted && isGameFinished.finished" />
</template>
<script>
	import QuestionComp from '@/components/QuestionComp.vue';
	import StartPage from '@/components/StartPage.vue';
	import FinishGame from './FinishComp.vue';
	export default {
		components: {
			QuestionComp,
			StartPage,
			FinishGame,
		},
		data() {
			return {
				isGameStarted: false,
				resetGame: { reset: false },
				isGameFinished: { finished: false },
				userName: '',
				score: { score: '' },
			};
		},
		methods: {
			startGame(userName) {
				this.userName = userName;
				this.isGameStarted = true;
			},
			reset() {
				this.isGameFinished.finished = false;
			},
		},
		provide() {
			return {
				startGame: this.startGame,
				isGameFinished: this.isGameFinished,
				score: this.score,
				userName: this.userName,
			};
		},
	};
</script>
