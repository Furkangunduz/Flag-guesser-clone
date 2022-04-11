<!-- @format -->

<template>
	<div class="card">
		<div v-if="score > 0" class="score">
			<p>
				Score :
				<span style="color: darkcyan; font-size: 1.5rem">{{ score }}</span>
			</p>

			<p>
				Left
				<span style="color: darkcyan; font-size: 1.5rem">
					{{ countriesLen - index + 1 }}</span
				>
				flag
			</p>
		</div>
		<div class="flag">
			<img :src="img" alt="" />
		</div>
		<div class="buttons">
			<button @click="choose">{{ AnswersList[0] }}</button>
			<button @click="choose">{{ AnswersList[1] }}</button>
			<button @click="choose">{{ AnswersList[2] }}</button>
			<button @click="choose">{{ AnswersList[3] }}</button>
		</div>
	</div>
</template>

<script>
	/*eslint no-constant-condition: ["error", { "checkLoops": false }]*/

	import countries from '../../country_names';
	const axios = require('axios');
	export default {
		data() {
			return {
				db: 'https://my-json-server.typicode.com/Furkangunduz/flag-guesser-clone/leaderBoard',
				country: '',
				index: 0,
				img: '',
				AnswersList: ['', '', '', ''],
				answer: '',
				countriesLen: countries.length,
			};
		},
		inject: ['isGameFinished', 'userName', 'score'],

		created() {
			this.nextQuestion();
			this.score = 0;
		},

		methods: {
			//call This after every choice and check answer
			choose(ClickedButton) {
				console.log(ClickedButton);
				if (ClickedButton) {
					let buttons = document.querySelectorAll('button');
					let btnText = ClickedButton.target.outerText;
					//disabled buttons till next question
					buttons.forEach((button) => {
						button.disabled = true;
					});
					//if true make green button and wait for 1 sec
					if (this.checkAnswer(btnText)) {
						console.log(this.userName.userName);
						this.score++;
						ClickedButton.target.classList.add('true');
						setTimeout(() => {
							if (this.index < countries.length) {
								//enable buttons after 3 sec
								buttons.forEach((button) => {
									button.classList.remove('true');
									button.classList.remove('false');
									button.disabled = false;
								});
								this.nextQuestion();
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
							if (this.index <= countries.length) {
								//enable buttons after 3 sec
								buttons.forEach((button) => {
									button.classList.remove('true');
									button.classList.remove('false');
									button.disabled = false;
								});
								this.nextQuestion();
							}
						}, 1000);
					}
				}
				if (this.index == countries.length) {
					this.isGameFinished.finished = true;
					this.AddLeaderBoardUser();
				}
			},
			//get next question and increase index of question
			nextQuestion() {
				this.getData();
				this.index++;
			},
			// get data from api with axios then set variables for questions
			getData() {
				axios.get(`https://restcountries.com/v3.1/name/${countries[this.index]}`).then(
					(res) => {
						this.country = res.data[0].name.common;
						this.img = res.data[0].flags['png'];
						this.setAnswers();
					}
				);
			},
			//set 1 correct answer from question info and
			//3 random answers from countries list
			setAnswers() {
				let correctIndex = Math.floor(Math.random() * 4);
				this.AnswersList[correctIndex] = this.country;
				for (let i = 0; i < 4; i++) {
					if (i != correctIndex) {
						let answer = countries[Math.floor(Math.random() * 30)];
						if (!this.AnswersList.some((i) => i == answer))
							this.AnswersList[i] = answer;
						else {
							while (true) {
								let answer = countries[Math.floor(Math.random() * 30)];
								if (!this.AnswersList.some((i) => i == answer)) {
									this.AnswersList[i] = answer;
									break;
								}
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
			AddLeaderBoardUser() {
				let user = { 'username': this.userName.userName, 'score': this.score };
				axios.post(this.db, user)
					.then((res) => {
						console.log(res);
					})
					.catch((res) => {
						console.log(res);
					});
			},
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
	};
</script>
