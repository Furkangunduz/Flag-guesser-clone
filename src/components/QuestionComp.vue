<template>
	<div class="card">
		<div class="score">Score : {{ QuestionInfo.index - 1 }}</div>
		<div class="flag">
			<img :src="QuestionInfo.img" alt="" />
		</div>
		<div class="buttons">
			<button @click="nextQuestion">{{ AnswersList[0] }}</button>
			<button @click="nextQuestion">{{ AnswersList[1] }}</button>
			<button @click="nextQuestion">{{ AnswersList[2] }}</button>
			<button @click="nextQuestion">{{ AnswersList[3] }}</button>
		</div>
	</div>
</template>

<script>
	import countries from '../../country_names';

	const axios = require('axios');
	export default {
		data() {
			return {
				QuestionInfo: {
					country: '',
					index: 0,
					img: '',
					score: '',
				},
				AnswersList: ['', '', '', ''],
				answer: '',
			};
		},
		inject: ['isGameFinished', 'score'],

		created() {
			this.nextQuestion('');
		},
		methods: {
			nextQuestion(e) {
				if (e) {
					if (!this.checkAnswer(e.target.outerText)) {
						this.score.score = this.QuestionInfo.index - 1;
						this.isGameFinished.finished = true;
					}
				}
				if (this.QuestionInfo.index < countries.length - 1) {
					this.getData();
					this.QuestionInfo.index++;
				}
			},
			getData() {
				axios
					.get(`https://restcountries.com/v3.1/name/${countries[this.QuestionInfo.index]}`)
					.then((res) => {
						this.QuestionInfo.country = res.data[0].name.common;
						this.QuestionInfo.img = res.data[0].flags['png'];
						console.log(res.data[0].flags['png']);
						this.setAnswers();
					});
			},
			setAnswers() {
				let correctIndex = Math.floor(Math.random() * 4);
				this.AnswersList[correctIndex] = this.QuestionInfo.country;
				console.log(correctIndex);
				for (let i = 0; i < 4; i++) {
					if (i != correctIndex) {
						let answer = countries[Math.floor(Math.random() * 10)];
						if (!this.AnswersList.some((i) => i == answer)) this.AnswersList[i] = answer;
						else {
							let answer = countries[Math.floor(Math.random() * 10)];
							while (!this.AnswersList.some((i) => i == answer)) {
								this.AnswersList[i] = answer;
							}
						}
					}
				}
			},
			checkAnswer(answer) {
				console.log(answer);
				this.answer = answer;
				if (this.answer) {
					if (this.answer == this.QuestionInfo.country) {
						return true;
					} else false;
				}
			},
			resetData() {
				this.isGameFinished = false;
				this.QuestionInfo = {
					country: '',
					index: 0,
					img: '',
					score: '',
				};
				this.AnswersList = ['', '', '', ''];
			},
		},
	};
</script>
<style scoped>
	.card {
		display: flex;
		flex-direction: column;
		background-color: rgba(255, 255, 255, 0.8);
		padding: 50px 25px;
		width: 30%;
		text-align: center;
	}
	.card .score {
		background: rgba(0, 0, 0, 0.2);
		margin-bottom: 20px;
		display: inline;
	}
	.buttons {
		display: flex;
		flex-direction: column;
		margin-top: 50px;
		height: 120px;
		justify-content: space-evenly;
		align-items: center;
	}
	.buttons button {
		background-color: rgb(83, 83, 83);
		color: rgb(208, 208, 208);
		width: 50%;
		margin-top: 10px;
		border-radius: 10px;
		font-size: 20px;
		padding: 2px 0;
		cursor: pointer;
	}
	.buttons button:hover {
		background-color: rgb(212, 212, 212);
		color: rgb(67, 67, 67);
	}
	.flag {
		width: 300px;
		height: 200px;
		margin: auto;
	}
	.flag img {
		width: 100%;
		height: 100%;
	}
</style>
