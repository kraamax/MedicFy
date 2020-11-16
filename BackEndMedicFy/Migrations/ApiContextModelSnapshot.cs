﻿// <auto-generated />
using System;
using BackEndMedicFy.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace BackEndMedicFy.Migrations
{
    [DbContext(typeof(ApiContext))]
    partial class ApiContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .UseIdentityColumns()
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.0");

            modelBuilder.Entity("BackEndMedicFy.Models.Duration", b =>
                {
                    b.Property<int>("DurationId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<string>("FinalDate")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("InitialDate")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("haveFinalDate")
                        .HasColumnType("bit");

                    b.HasKey("DurationId");

                    b.ToTable("Durations");
                });

            modelBuilder.Entity("BackEndMedicFy.Models.Frequency", b =>
                {
                    b.Property<int>("FrequencyId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<int>("DaysNumber")
                        .HasColumnType("int");

                    b.Property<string>("Type")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("FrequencyId");

                    b.ToTable("Frequencies");
                });

            modelBuilder.Entity("BackEndMedicFy.Models.Medicament", b =>
                {
                    b.Property<int>("MedicamentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<int?>("DurationId")
                        .HasColumnType("int");

                    b.Property<int?>("FrequencyId")
                        .HasColumnType("int");

                    b.Property<string>("MedicamentName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Schedule")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Units")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("MedicamentId");

                    b.HasIndex("DurationId");

                    b.HasIndex("FrequencyId");

                    b.ToTable("Medicaments");
                });

            modelBuilder.Entity("BackEndMedicFy.Models.Medicament", b =>
                {
                    b.HasOne("BackEndMedicFy.Models.Duration", "Duration")
                        .WithMany()
                        .HasForeignKey("DurationId");

                    b.HasOne("BackEndMedicFy.Models.Frequency", "Frequency")
                        .WithMany()
                        .HasForeignKey("FrequencyId");

                    b.Navigation("Duration");

                    b.Navigation("Frequency");
                });
#pragma warning restore 612, 618
        }
    }
}
