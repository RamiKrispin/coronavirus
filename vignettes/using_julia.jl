# This is the source code for the "Loading Data with Julia" vignette:
#
using Pkg

Pkg.activate("covid19_env")
Pkg.add(PackageSpec(name = "PlotlyJS", version = "0.18.8"))
Pkg.add(PackageSpec(name = "CSV", version = "0.9.6"))
Pkg.add(PackageSpec(name = "Chain", version = "0.4.8"))
Pkg.add(PackageSpec(name = "DataFrames", version = "1.2.2"))

using  CSV, DataFrames, Chain, PlotlyJS

Pkg.status()

# Loading the data
url = "https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/coronavirus_2023.csv"
file = CSV.File(download(url), missingstring= "NA")

df = DataFrame(file)
df

describe(df)

@chain df begin
    filter(:type => ==("confirmed"),_)
    groupby([:combined_key, :type])
    combine([:cases] .=> sum)
    sort!([:cases_sum], rev = true)
end

@chain df begin
    filter(:type => ==("death"),_)
    groupby([:combined_key, :type])
    combine([:cases] .=> sum)
    sort!([:cases_sum], rev = true)
end

# Visualize the data
df_brazil_confirmed = filter(row -> row.country == "Brazil" && row.type == "confirmed", df)
df_brazil_death = filter(row -> row.country == "Brazil" && row.type == "death", df)


p = make_subplots(rows=2,
                  cols=1,
                  shared_xaxes=true,
                  x_title = "Source: Johns Hopkins University Center for Systems Science and Engineering",
                  vertical_spacing=0.02)

add_trace!(p, scatter(df_brazil_confirmed,x=:date, y=:cases, name = "Confirmed"), row=1, col=1)
add_trace!(p, scatter(df_brazil_death,x=:date, y=:cases, name = "Death"), row=2, col=1)

relayout!(p, title_text="Brazil - Daily Confirmed and Death Cases")
p

