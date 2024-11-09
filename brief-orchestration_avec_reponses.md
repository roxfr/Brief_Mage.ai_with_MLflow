VOIR DOSSIERS/FICHIERS ASSOCIES :
- pipeline_backup/taxi_pipeline.zip
- images/Q6.png
- images/Q7.png

# Brief

The goal of this brief is to create a simple training pipeline, use mlflow to track experiments and register best model, but use Mage for it.

We'll use [the same NYC taxi dataset](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page), the **Yellow** taxi data for March, 2023.

## Question 1. Run Mage

First, let's run Mage with Docker Compose. Follow the quick start guideline.

What's the version of Mage we run?

(You can see it in the UI)

**v0.9.73**

## Question 2. Creating a project

Now let's create a new project. We can call it "brief_03", for example.

How many lines are in the created `metadata.yaml` file?

- 35
- 45
- 55
- 65

**55**

## Question 3. Creating a pipeline

Let's create an ingestion code block.

In this block, we will read the March 2023 Yellow taxi trips data.

How many records did we load?

- 3,003,766
- 3,203,766
- 3,403,766
- 3,603,766

**3,403,766**

## Question 4. Data preparation


Let's use the same logic for preparing the data we used previously. 
We will need to create a transformer code block and put this code there.

This is what we used (adjusted for yellow dataset):

Let's adjust it and apply to the data we loaded in question 3.

What's the size of the result?


- 2,903,766
- 3,103,766
- 3,316,216
- 3,503,766

**3,316,216**

## Question 5. Train a model

We will now train a linear regression model using the same code as in homework 01.

* Fit a dict vectorizer.
* Train a linear regression with default parameters.
* Use pick up and drop off locations separately, don't create a combination feature.

Let's now use it in the pipeline. 
We will need to create another transformation block, 
and return both the dict vectorizer and the model.

What's the intercept of the model?

Hint: print the `intercept_` field in the code block

- 21.77
- 24.77
- 27.77
- 31.77

**24.77**

## Question 6. Register the model

The model is trained, so let's save it with MLFlow.

If you run mage with docker-compose, stop it with Ctrl+C or

```bash
docker-compose down
```

Let's create a dockerfile for mlflow, e.g. `mlflow.dockerfile`:

```dockerfile
FROM python:3.10-slim

RUN pip install mlflow==2.12.1

EXPOSE 5000

CMD [ \
    "mlflow", "server", \
    "--backend-store-uri", "sqlite:///home/mlflow_data/mlflow.db", \
    "--host", "0.0.0.0", \
    "--port", "5000" \
]
```

And add it to the docker-compose.yaml:

```yaml
  mlflow:
    build:
      context: .
      dockerfile: mlflow.dockerfile
    ports:
      - "5000:5000"
    volumes:
      - "${PWD}/mlflow_data:/home/mlflow_data/"
    networks:
      - app-network
```

Note that `app-network` is the same network as for mage and postgres containers.
If you use a different compose file, adjust it.

We should already have `mlflow==2.12.1` in requirements.txt in the mage project we created for the module. 
If you're starting from scratch, add it to your requirements.

Next, start the compose again and create a data exporter block.

In the block, we

* Log the model (linear regression)
* Save and log the artifact (dict vectorizer)

If you used the suggested docker-compose snippet, mlflow should be accessible at `http://mlflow:5000`.

Find the logged model, and find MLModel file. What's the size of the model? (`model_size_bytes` field):

* 14,534
* 9,534
* 4,534
* 1,534

**4,534** (model_size_bytes: 4598)

> Note: typically we do last two steps in one code block.

## Question 7. Plot Metrics

Modify your code so that it calculates MAE, MSE, and RMSE metrics and logs them to mlflow.

Fetch the logged metrics from MLFlow and plot them in a chart in your pipeline's dashboard.

**Logged metrics - MAE: 6.1210891479860745, MSE: 66.56408336057764, RMSE: 8.158681471940037**

## Push your solution to GitHub

Push your whole directory (the one parent to the docker-compose.yaml) to GitHub.

Submit your answers and the link to your github repository on Simplonline ;)

Don't forget to put it in public mode so we can access it!