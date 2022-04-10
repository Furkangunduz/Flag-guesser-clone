<template>
	<start-page v-if="!isGameStarted" />
	<question-comp v-if="isGameStarted && !isGameFinished.finished" />
	<finish-game v-if="isGameStarted && isGameFinished.finished" />
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
				isGameFinished: { finished: false },
				userName: '',
				score: { score: '' },
			};
		},
		methods: {
			startGame(userName) {
				this.userName = userName;
				this.isGameStarted = true;
				// alert('please write your name');
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
