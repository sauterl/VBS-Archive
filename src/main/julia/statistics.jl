using JSON, CSV, DataFrames, Statistics, DataFramesMeta, Latexify;

# DRES VBS files
vbs21 = JSON.parsefile("2021/run.json");
vbs22 = JSON.parsefile("2022/run_vbs_2022.json");
vbs23 = JSON.parsefile("2023/vbs23_run.json");
vbs24 = JSON.parsefile("2024/VBS_2024_run_export_filtered.json");

# The resulting DataFrame

stats = DataFrame(Year=Int[],Teams=Int[], Groups=Int[], Tasks=Int[], Submissions=Int[]);

# VBS 21
nbTeams21 = length(vbs21["description"]["teams"]);
teams21Map = Dict(map(x -> x["uid"] => x["name"], vbs21["description"]["teams"]));
nbGroups21 = length(vbs21["description"]["taskGroups"]);
tasks21 = filter( x -> x["hasStarted"], vbs21["tasks"]);
nbTasks21 = length(tasks21);

# Build submisisons table
submissions21 = DataFrame[];
for t in tasks21
    taskName = t["description"]["name"];
    taskGroup = t["description"]["taskGroup"]["name"];
    taskStart = t["started"] + 5000; # five seconds countdown is added
    
    for s in t["submissions"]
        push!(submissions21, DataFrame(
            task=taskName,
            group=taskGroup,
            time=s["timestamp"] - taskStart,
            team=teams21Map[s["teamId"]],
            member=s["memberId"],
            item=s["item"]["name"],
            start=s["start"],
            ending=s["end"],
            status=s["status"]
        ));
    end
end
submissions21 = vcat(submissions21...);

nbSubmissions21 = size(submissions21,1);

# Fill 21 data to DataFrame
push!(stats, (2021, nbTeams21, nbGroups21, nbTasks21, nbSubmissions21));
# ---

# VBS 22
nbTeams22 = length(vbs22["description"]["teams"]);
teams22Map = Dict(map(x -> x["uid"]["string"] => x["name"], vbs22["description"]["teams"]));
nbGroups22 = length(vbs22["description"]["taskGroups"]);
tasks22 = filter( x -> x["hasStarted"], vbs22["tasks"]);
nbTasks22 = length(tasks22);

# Build submisisons table
submissions22 = DataFrame[];
for t in tasks22
    taskName = t["description"]["name"];
    taskGroup = t["description"]["taskGroup"]["name"];
    taskStart = t["started"] + 5000; # five seconds countdown is added
    
    for s in t["submissions"]
        push!(submissions22, DataFrame(
            task=taskName,
            group=taskGroup,
            time=s["timestamp"] - taskStart,
            team=teams22Map[s["teamId"]["string"]],
            member=s["memberId"],
            item=s["item"]["name"],
            start=s["start"],
            ending=s["end"],
            status=s["status"]
        ));
    end
end
submissions22 = vcat(submissions22...);

nbSubmissions22 = size(submissions22,1);

# Fill 22 data to DataFrame
push!(stats, (2022, nbTeams22, nbGroups22, nbTasks22, nbSubmissions22));
# ---

# VBS 23
nbTeams23 = length(vbs23["description"]["teams"]);
teams23Map = Dict(map(x -> x["uid"] => x["name"], vbs23["description"]["teams"]));
nbGroups23 = length(vbs23["description"]["taskGroups"]);
tasks23 = filter( x -> x["hasStarted"], vbs23["tasks"]);
nbTasks23 = length(tasks23);

# Build submisisons table
submissions23 = DataFrame[];
for t in tasks23
    taskName = t["description"]["name"];
    taskGroup = t["description"]["taskGroup"]["name"];
    taskStart = t["started"] + 5000; # five seconds countdown is added
    
    for s in t["submissions"]
        push!(submissions23, DataFrame(
            task=taskName,
            group=taskGroup,
            time=s["timestamp"] - taskStart,
            team=teams23Map[s["teamId"]],
            member=s["memberId"],
            item=s["item"]["name"],
            start=s["start"],
            ending=s["end"],
            status=s["status"]
        ));
    end
end
submissions23 = vcat(submissions23...);

nbSubmissions23 = size(submissions23,1);

# Fill 23 data to DataFrame
push!(stats, (2023, nbTeams23, nbGroups23, nbTasks23, nbSubmissions23));
# ---

# VBS 24 | DRES v2 model
nbTeams24 = length(vbs24["template"]["teams"]);
teams24Map = Dict(map(x -> x["id"] => x["name"], vbs24["template"]["teams"]));
nbGroups24 = length(vbs24["template"]["taskGroups"]);
tasks24 = filter( x -> x["started"] > 0 && x["ended"] > 0, vbs24["tasks"]);
nbTasks24 = length(tasks24);

# Build submisisons table
submissions24 = DataFrame[];
for t in tasks24
    taskName = filter(x -> x["id"] == t["templateId"], vbs24["template"]["tasks"])[1]["name"];
    taskGroup = filter(x -> x["id"] == t["templateId"], vbs24["template"]["tasks"])[1]["taskGroup"];
    taskStart = t["started"] + 5000; # five seconds countdown is added
    
    for s in t["submissions"]
        push!(submissions24, DataFrame(
            task=taskName,
            group=taskGroup,
            # time=s["timestamp"] - taskStart, # There is no timestamp field
            #team=teams23Map[s["teamId"]],
            #member=s["memberId"],
            #item=s["item"]["name"],
            #start=s["start"],
            #ending=s["end"],
            status=s["status"]
        ));
    end
end
submissions24 = vcat(submissions24...);

nbSubmissions24 = size(submissions24,1);

# Fill 24 data to DataFrame
push!(stats, (2024, nbTeams24, nbGroups24, nbTasks24, nbSubmissions24));
# ---

latexify(stats[:,:], env=:table, latex=false)