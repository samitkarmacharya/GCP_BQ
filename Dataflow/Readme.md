# Google Dataflow

Dataflow is a managed service for running Apache Beam pipelines. In this example we are going to stream sentences from a Pub/Sub topic, split the sentences into words and count the frequency of each word and write the another Pub/Sub topic for further processing.

## Setup

1. Run the script `publish_text.py` in a terminal, you will be prompted to enter a sentence. Let it hang here, while you run the dataflow job.
2. Run the apache beam pipeline `streaming_word_count.py` in the terminal. This will start the dataflow job. You can see the job running in the google cloud console.

```bash
python Dataflow/streaming_word_count.py \
  --runner DataflowRunner \
  --project gcp-de-foundations \
  --region us-central1 \
  --streaming \
  --requirements_file Dataflow/dataflow-requirements.txt \
  --job_name streaming-word-counter --update
```

3. To see the output, run the script `listen_to_output.py` in another terminal. Write a few sentences in the first terminal and press enter. You will see the output of the word count.
The output messages will be like this:

```bash
Received message: Message {
  data: b'are: 3'
  ordering_key: ''
  attributes: {}
}
Received message: Message {
  data: b'waiting: 3'
  ordering_key: ''
  attributes: {}
}   
```