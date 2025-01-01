# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tsadouk <tsadouk@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/19 15:29:51 by tsadouk           #+#    #+#              #
#    Updated: 2024/12/19 15:29:56 by tsadouk          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all: up

up:
	@printf "Starting Docker containers...\n"
	@docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@printf "Stopping Docker containers...\n"
	@docker-compose -f srcs/docker-compose.yml down

clean: down
	@printf "Cleaning up Docker resources...\n"
	@docker system prune -a

fclean: clean
	@printf "Full cleanup...\n"
	@docker volume rm $$(docker volume ls -q)

re: fclean all

.PHONY: all up down clean fclean re