<template>
	<div class="card">
		<img :src="QuestionInfo.img" alt="" />
		<div class="buttons">
			<button @click="nextFlag">{{ AnswersList.arr[0] }}</button>
			<button @click="nextFlag">{{ AnswersList.arr[1] }}</button>
			<button @click="nextFlag">{{ AnswersList.arr[2] }}</button>
			<button @click="nextFlag">{{ AnswersList.arr[3] }}</button>
		</div>
	</div>
</template>
<script>
	export default {
		inject: ['nextFlag', 'QuestionInfo', 'AnswersList'],
	};
</script>

<style>
	.card {
		display: flex;
		flex-direction: column;
		background-color: rgba(255, 255, 255, 0.8);
		padding: 50px 25px;
		width: 30%;
	}
	.buttons {
		display: flex;
		flex-direction: column;
		margin-top: 30px;
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
</style>
