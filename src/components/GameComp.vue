<template>
	<start-page v-if="!isGameStarted" />
	<question-comp v-else />
</template>
<script>
	import QuestionComp from '@/components/QuestionComp.vue';
	import StartPage from '@/components/StartPage.vue';
	export default {
		components: {
			QuestionComp,
			StartPage,
		},
		data() {
			return {
				isGameStarted: false,
				userName: '',
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
			};
		},
	};
</script>
