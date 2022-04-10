<template>
	<div class="card">
		<div v-if="score.score > 0" class="score">
			<p>
				Score : <span style="color: darkcyan; font-size: 1.5rem">{{ score.score }}</span>
			</p>

			<p>
				Left
				<span style="color: darkcyan; font-size: 1.5rem"> {{ countriesLen - index }}</span> flag
				!
			</p>
		</div>
		<div class="flag">
			<img :src="img" alt="" />
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
				country: '',
				index: 0,
				img: '',
				AnswersList: ['', '', '', ''],
				answer: '',
				countriesLen: countries.length,
			};
		},
		inject: ['isGameFinished', 'score'],

		created() {
			this.nextQuestion('');
			this.score.score = 0;
		},

		methods: {
			nextQuestion(ClickedButton) {
				if (this.index >= countries.length - 1) {
					this.isGameFinished.finished = true;
					return;
				}
				//first initilazied we dont have clicked button
				//because of this call get data when start game
				if (!ClickedButton) {
					this.getData();
					this.index++;
				} else {
					let buttons = document.querySelectorAll('button');
					let btnText = ClickedButton.target.outerText;
					//disabled buttons till next question
					buttons.forEach((button) => {
						button.disabled = true;
					});
					//if true make green button and wait for 1 sec
					if (this.checkAnswer(btnText)) {
						ClickedButton.target.classList.add('true');
						setTimeout(() => {
							if (this.index < countries.length - 1) {
								this.getData();
								this.score.score++;
								this.index++;
								//enable buttons after 3 sec
								buttons.forEach((button) => {
									button.classList.remove('true');
									button.classList.remove('false');
									button.disabled = false;
								});
							}
						}, 800);
					}
					//if not true make red button and wait 2 sec
					else {
						ClickedButton.target.classList.add('false');
						buttons.forEach((button) => {
							if (button.outerText == this.country) {
								button.classList.add('true');
							}
						});
						setTimeout(() => {
							if (this.index < countries.length - 1) {
								this.getData();
								this.index++;
								//enable buttons after 3 sec
								buttons.forEach((button) => {
									button.classList.remove('true');
									button.classList.remove('false');
									button.disabled = false;
								});
							}
						}, 1000);
					}
				}
			},
			// get data from api with axios then set variables for questions
			getData() {
				axios
					.get(`https://restcountries.com/v3.1/name/${countries[this.index]}`)
					.then((res) => {
						this.country = res.data[0].name.common;
						this.img = res.data[0].flags['png'];
						this.setAnswers();
					});
			},
			//set 1 correct answer from question info and
			//3 random answers from countries list
			setAnswers() {
				let correctIndex = Math.floor(Math.random() * 4);
				this.AnswersList[correctIndex] = this.country;
				for (let i = 0; i < 4; i++) {
					if (i != correctIndex) {
						let answer = countries[Math.floor(Math.random() * 20)];
						if (!this.AnswersList.some((i) => i == answer)) this.AnswersList[i] = answer;
						else {
							let answer = countries[Math.floor(Math.random() * 20)];
							while (!this.AnswersList.some((i) => i == answer)) {
								this.AnswersList[i] = answer;
							}
						}
					}
				}
			},
			//check Answer if it is true or false
			checkAnswer(answer) {
				this.answer = answer;
				if (this.answer) {
					if (this.answer == this.country) {
						return true;
					} else false;
				}
			},

			// setVarForGame() {
			// 	this.isGameFinished = false;
			// 	this.questionInfo = {
			// 		country: '',
			// 		index: 0,
			// 		img: '',
			// 		score: '',
			// 	};
			// 	this.AnswersList = ['', '', '', ''];
			// 	this.nextQuestion();
			// },
		},
	};
</script>
